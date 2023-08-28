const express = require("express");
const http = require("http");
const mongoose = require("mongoose");

const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
var io = require("socket.io")(server);
const Room = require('./models/room');

// middle ware
app.use(express.json());

const DB = "mongodb+srv://adnan:adnanali123@clustertictactoe.vh0pznb.mongodb.net/?retryWrites=true&w=majority";

io.on("connection", socket => {
    console.log("connected to socket");
    //  
    console.log(socket.id)
    //listening to events
    socket.on('createRoom', async ({ nickname }) => {
        console.log(nickname)

        try {
            //room is created
            let room = new Room();
            let player = {
                socketID: socket.id,
                nickname: nickname,
                playerType: 'X',
            };
            room.players.push(player);
            room.turn = player;

            //player is stored in room
            room = await room.save();

            const roomId = room._id;

            socket.join(roomId);
            console.log(room)


            //the room has been successfully created and player is taken to the next screen 
            io.to(roomId).emit("createRoomSuccess", room);
        } catch (e) {
            console.log(e)
        }

    });

    socket.on('joinRoom', async ({ nickname, roomId }) => {
        console.log(nickname)
        console.log(roomId)
        try {
            if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
                console.log('room id not found')
                socket.emit('errorOccurred', 'Please enter a valid room ID')
                return;
            }
            let room = await Room.findById(roomId);

            //the other user is joining the room
            if (room.isJoin) {
                let player = {
                    socketID: socket.id,
                    nickname: nickname,
                    playerType: 'O',
                }
                room.players.push(player);
                room.isJoin = false;
                socket.join(roomId);
                room = await room.save();
                io.to(roomId).emit("joinRoomSuccess", room);
                io.to(roomId).emit("updatePlayers", room.players);

                //this is for updating the game room when the room has been created and other user joins in
                io.to(roomId).emit("updateRoom", room);
            }
            else {
                socket.emit('errorOccurred', 'Game is in progress, try again later')
            }

        } catch (error) {
            console.log(e)
            socket.emit('errorOccurred', 'An error occurred')
            return;
        }

    });

    //displaying X and O in real-time
    socket.on('tap', async ({ index, roomId }) => {
        try {
            let room = await Room.findById(roomId);
            let choice = room.turn.playerType; // x or 0
            console.log(choice)
            //now we change the turns
            if (room.turnIndex == 0) {
                room.turnIndex = 1;
                room.turn = room.players[1];
            } else {
                room.turnIndex = 0;
                room.turn = room.players[0];
            }

            room = await room.save();

            io.to(roomId).emit('tapped', {
                index,
                choice,
                room
            });

        } catch (e) {
            console.log(e);
        }
    })

    //updating the score after winner
    socket.on('winner', async ({ winnerSocketId, roomId }) => {

        try {
            if (socket.id != winnerSocketId) { return; }
            let room = await Room.findById(roomId);
            let winnerPlayer = room.players.find((player) => player.socketID == winnerSocketId);
            console.log(winnerPlayer);
            winnerPlayer.points += 1;
            room = await room.save();

            io.to(roomId).emit('pointsIncreased', winnerPlayer);

            //event to check if the game has been over by checking it from maxrounds
            // if(playe)
        } catch (e) {
            console.log(e)
        }
    });
});

mongoose.connect(DB).then(() => {
    console.log("connected with DB")
})
    .catch((e) => {
        console.log(e)
    })

server.listen(port, "0.0.0.0", () => {
    console.log(`listening on port ${port}`)
})