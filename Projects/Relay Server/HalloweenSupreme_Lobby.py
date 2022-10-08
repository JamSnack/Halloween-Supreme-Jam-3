#Lobby class
from concurrent.futures import thread
from encodings import utf_8
import threading
import json

from numpy import real

class Lobby:
    def __init__(self, id, packet_size):
        self.id = id #lobby_id
        self.clients = [] #list of clients
        self.client_ids = [] #list of client IDs
        self.client_names = [] #list of client names
        self.lobby_host = None #the client who is hosting the lobby
        self.packet_size = packet_size
        self.next_player_id = 0 #Used to assign player ids

    def getId(self):
        return self.id

    def getClients(self):
        return self.clients

    def addClient(self, client, client_name):
        #The first player in the lobby is designated as the host.
        if (len(self.clients) == 0):
            self.lobby_host = client

        #Add the new client to clients and start a thread for them.
        self.clients.append(client)
        self.client_names.append(client_name)
        print(client_name + " added to lobby: "+str(self.id))
        
        #Spawn a thread for this client
        self.spawn_thread(client)

        #Send lobby info
        self.sendLobbyInfo(client)


    def removeClient(self, index):
        self.message_disconnect(self.lobby_host, self.client_ids[index])

        self.clients.pop(index)
        self.client_ids.pop(index)
        self.client_names.pop(index)


    def sendLobbyInfo(self, client):
        #construct data packet
        data = """{ "cmd" : "lobby_connect_success", "l_id" : """ + str(self.id) + """, "plr_id" : """ + str(self.next_player_id) + " }"

        #prepare data packet
        data = str(json.loads(data)).replace("'", '"')
        data = data.encode("utf_8")

        #send data packet
        client.send(data)
        
        #inform other clients that a player has connected
        if (client != self.lobby_host):

            data = self.constructPacket( cmd = '"player_connected"', p_id = str(self.next_player_id), p_n = '"' + str(self.client_names[len(self.client_names)-1]) + '"' ) #"""{ "cmd" : "player_connected", "p_id" : """ + str(self.next_player_id) + """ "p_n" : """ + str(self.client_names.pop()) + " }"
            print(data)
            data = str(json.loads(data)).replace("'", '"')
            data = data.encode("utf_8")
            
            self.broadcast(data, client)

        #Add new client ID to a list in such a way that the indexes between client_ids and clients match.
        self.client_ids.append(self.next_player_id)

        #Create the next player ID.
        self.next_player_id += 1


    # Sending packets to all clients, excluding the player who initially sent the packet (server to clients) OR send it to the packet to the lobby host (client to server)
    def broadcast(self, message, exclude):
        try:
            if (exclude == self.lobby_host):
                for client in self.clients:
                    if (client != exclude):
                            client.send(message)
            else:
                self.lobby_host.send(message)
        except:
            print("Error in broadcast: client probably doesn't exist. Close it")
    
     # Handling Messages From Clients
    def handle(self, client):
        while True:
            chunks = []
            break_client = False
            bytes_recvd = 0
            MSGLEN = self.packet_size

            #get packet length by receiving characters one at a time until finding our delimeter
            buf = ""

            while True:
                _char = client.recv(1)
                _char.decode('utf-8').replace('\x00', '')
                _char = str(int.from_bytes(_char, byteorder='big'))
                print("_char is: " + _char)
                #exception handling
                '''if not _char:
                    if buf:
                        raise RuntimeError("underflow")
                else:
                    print("breaking...")
                    break'''
                
                #we've found the header else we're still looking for it:
                if _char == "|":
                    MSGLEN = int(buf)
                    print("MSGLEN is: " + str(MSGLEN))
                    break
                elif _char != "":
                    buf = buf + _char

                print("buffer is currently: " + buf)

            #unpack the rest of the data
            while bytes_recvd < MSGLEN:
                try:
                    # Relay those messages!
                    message = client.recv(min(MSGLEN - bytes_recvd, self.packet_size))

                    chunks.append(message)
                    bytes_recvd = bytes_recvd + len(message)
                    
                    #print("Data is: "+str(message))
                    self.broadcast(message, client)
                except:
                    break_client = True
                    break

            #Disconnect the client.
            if break_client:
                index = self.clients.index(client)
                self.removeClient(index)
                client.close()
                print("Client removed from lobby: "+str(self.id))

    def spawn_thread(self, client):
        thread = threading.Thread(target=self.handle, args=(client,))
        thread.start()


    def toString(self):
        _str = str(self.getId())+":\n- Clients:\n"

        for c in self.clients:
            _str += "-- "+str(c)+"\n"

        return _str

    # Properly unpack packets and split them
    def preparePacket(packet):
        packet_strings = packet.split("{")
        loaded_packet_list = []

        for i in packet_strings:
            if (i != ""):
                new_string = "{"+i
                new_string = json.loads(new_string)
                loaded_packet_list.append(new_string)

        return loaded_packet_list

    def constructPacket(self, **data):
        _counter = 0
        str_json = "{"
        for key, value in data.items():
            if (_counter > 0):
                str_json += ","

            str_json += f""" "{key}" : {value}"""
            _counter += 1

        str_json += "}"
        #print("String json: "+str_json)
        #str_json = json.loads(str_json)
        str_json = str_json.encode("utf-8") #encode the json into byte form
        return str_json


    def message_disconnect(self, client, id):
        message = self.constructPacket(cmd='"player_disconnected"', p_id = id)

        #broadcast to all clients. Edit: Gonna bounce this from the server so that we're using new framework & the server is in charge over the relay server.
        #self.broadcast(message, client)

        #broadcast to just host
        try:
            self.lobby_host.send(message)
        except:
            self.lobby_host.close()



    
