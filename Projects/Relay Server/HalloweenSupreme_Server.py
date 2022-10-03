import socket
import threading
import json
import HalloweenSupreme_Lobby as Lobby
from ast import literal_eval

#Python version 3.10

# Connection Data
ip = '127.0.0.1'
port = 55555
packet_size = 4096

# Starting Server
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind((ip, port))
server.listen()

test = """{ "cmd": "lobby_info", "id": 0.0 }"""
print(test)
print(type(test))
print(len(test))
test = json.loads(test)
print("Decode Test: "+str(test["id"]))

# List of lobbies
lobbies = []

# Properly unpack packets and split them
def preparePacket(packet):
    packet_strings = packet.split("{")
    #print("packet_strings: "+str(packet_strings))
    loaded_packet_list = []

    for i in packet_strings:
        if (i != ""):
            new_string = "{"+i
            #print("i: "+str(i))
            #print("New string: "+new_string)
            new_string = json.loads(new_string)
            loaded_packet_list.append(new_string)

    #print("Completed Json: "+str(loaded_packet_list))
    return loaded_packet_list

# Receiving / Listening Function
def receive():
    next_id = 1000

    while True:
        # Accept Connection
        client, address = server.accept()
        print("---NEW CONNECTION---")
        print("Connected with {}".format(str(address)))

        #Add the client to the correct lobby
        #NOTE: Client.recv MUST recieve the lobby_id packet. That means that we should later set up a temporary handler 
        #that expects to receive packets from the client AND THEN have the lobby placement code inside that
        lobby_id = -1
        packet_list = []

        try:
            print("Waiting for lobby_info packet...")
            lobby_packet = client.recv(packet_size) #expect a lobby_info packet from the player!
            lobby_packet = lobby_packet.decode('utf-8').replace('\x00', '')
            print(lobby_packet)
            packet_list = preparePacket(lobby_packet).copy()

            # Extract the correct id
            if type(packet_list) is list:
                for packet in packet_list:
                    if type(packet) is dict:
                        if (packet["cmd"] == "lobby_info"):
                            lobby_id = packet["id"]
                            break
        except:
            print("Some exception...")
            
        print("Requested Lobby ID:" + str(lobby_id))
        _success = False

        if (lobby_id != -1):
            #- Look for an existing lobby to add the client into
            for lobby in lobbies:
                if (lobby.getId() == lobby_id):
                    lobby.addClient(client)
                    _success = True
                elif (len(lobby.getClients()) == 0):
                    #The lobby is empty, destroy it.
                    lobbies.remove(lobby)
                    print("Lobby removed: "+str(lobby.getId()))

                #print(lobby.toString())

            #- If a lobby doesn't exist, make one and add the client to that.
        if (_success == False and lobby_id == 0 and isinstance(lobby_id,float)):
            temp_lobby = Lobby.Lobby(next_id, packet_size)
            print("Lobby created: "+str(temp_lobby.getId()))

            temp_lobby.addClient(client)
            lobbies.append(temp_lobby)

            next_id += 1

            _success = True

        #If _success is still false at this point, the client failed to enter a lobby. Disconnect them so that they can try again.
        if (_success == False):
            client.close()

        print("------")

#Begin the server
receive()
