//: Playground - noun: a place where people can play

import UIKit

enum Direction {
    case north
    case south
    case east
    case west
}

// MARK: MapSite
protocol MapSite {
    func enter()
}

extension MapSite {
    func enter() {
        
    }
}

// MARK: Room
protocol RoomType: MapSite {
    var roomNo: Int { set get }
    var sides: [MapSite?] { set get }
    mutating func setSide(direct: Direction, site: MapSite)
}

extension RoomType {
    func getSide(direct: Direction) -> MapSite? {
        return sides[direct.hashValue]
    }
    
    mutating func setSide(direct: Direction, site: MapSite) {
        sides[direct.hashValue] = site
    }
}

struct Room: RoomType {
    var roomNo: Int
    var sides: [MapSite?] = [nil, nil, nil, nil]
    init(roomNo: Int) {
        self.roomNo = roomNo
    }
}

extension Room: CustomStringConvertible {
    var description: String {
        return "Room"
    }
}

func ==(lhs: RoomType, rhs: RoomType) -> Bool {
    return lhs.roomNo == rhs.roomNo
}

// MARK: Wall
protocol WallType: MapSite {
    
}

struct Wall: WallType {
    
}

extension Wall: CustomStringConvertible {
    var description: String {
        return "Wall"
    }
}

// MARK: Door
protocol DoorType: MapSite {
    
}

struct Door: DoorType {
    var isOpen = false
    var room1: RoomType
    var room2: RoomType
    
    init(r1: RoomType, r2: RoomType) {
        room1 = r1
        room2 = r2
    }
    
    mutating func otherSide(form room: RoomType) -> RoomType {
        isOpen = true
        if (room == room1) {
            return room2
        } else {
            return room1
        }
    }
}

extension Door: CustomStringConvertible {
    var description: String {
        return "Door"
    }
}

// MARK: Maze
struct Maze {
    var roomDic: [String: RoomType] = [:]
    
    mutating func addRoom(room: RoomType) {
        roomDic["room_\(room.roomNo)"] = room
    }
    
    func room(roomNo: Int) -> RoomType? {
        return roomDic["room_\(roomNo)"]
    }
}

extension Maze: CustomStringConvertible {
    
    var description: String {
        
        var desc = "===========================\n"
        desc += "Maze room:\n"
        
        for (key, value) in roomDic {
            
            desc += "\(key) \(value) \n"
            desc += "north is \(value.getSide(direct: .north))\n"
            desc += "south is \(value.getSide(direct: .south))\n"
            desc += "east is \(value.getSide(direct: .east))\n"
            desc += "west is \(value.getSide(direct: .west))\n"
            
        }
        
        desc += "===========================\n"
        
        return desc
    }
}

// MARK: MazeFactory
protocol MazeFactory {
    associatedtype RoomMazeType: RoomType
    associatedtype WallMazeType: WallType
    associatedtype DoorMazeType: DoorType
    
    func makeRoom(_ n: Int) -> RoomMazeType
    func makeWall() -> WallMazeType
    func makeDoor(_ r1: RoomMazeType, _ r2: RoomMazeType) -> DoorMazeType
    func makeMaze() -> Maze
}

extension MazeFactory {
    func makeMaze() -> Maze {
        return Maze()
    }
    
    func makeRoom(_ n: Int) -> Room {
        return Room(roomNo: n)
    }
    
    func makeWall() -> Wall {
        return Wall()
    }
    
    func makeDoor(_ r1: Room, _ r2: Room) -> Door {
        return Door(r1: r1, r2: r2)
    }
}

struct NormalMazeFactory: MazeFactory {
    
}

//: 定义一个迷宫游戏，通过 createMaze 方法来创建游戏中的迷宫
struct MazeGame {
    
    static func createMaze<T: MazeFactory>(mazeFactory: T) -> Maze {
        
        var maze = mazeFactory.makeMaze()
        var r1 = mazeFactory.makeRoom(1)
        var r2 = mazeFactory.makeRoom(2)
        let theDoor = mazeFactory.makeDoor(r1, r2)
        
        r1.setSide(direct: .north, site: mazeFactory.makeWall())
        r1.setSide(direct: .east, site: theDoor)
        r1.setSide(direct: .south, site: mazeFactory.makeWall())
        r1.setSide(direct: .west, site: mazeFactory.makeWall())
        
        r2.setSide(direct: .north, site: mazeFactory.makeWall())
        r2.setSide(direct: .east, site: mazeFactory.makeWall())
        r2.setSide(direct: .south, site: mazeFactory.makeWall())
        r2.setSide(direct: .west, site: theDoor)
        
        maze.addRoom(room: r1)
        maze.addRoom(room: r2)
        
        return maze
    }
}

var normalMazeFactory = NormalMazeFactory()
var normalMaze = MazeGame.createMaze(mazeFactory: normalMazeFactory)
print(normalMaze)




/*********************************
 * New Feature
 *********************************/
struct Spell {
    
}

struct EnchantedRoom: RoomType {
    var roomNo: Int
    var sides: [MapSite?] = [nil, nil, nil, nil]
    var castSpell: Spell
    
    init(_ n: Int, spell: Spell) {
        roomNo = n
        castSpell = spell
    }
}

extension EnchantedRoom: CustomStringConvertible {
    var description: String {
        return "EnchantedRoom"
    }
}

struct DoorNeedingSpell: DoorType {
    
    init(r1: EnchantedRoom, r2: EnchantedRoom) {
        
    }
}

extension DoorNeedingSpell: CustomStringConvertible {
    var description: String {
        return "DoorNeedingSpell"
    }
}

struct EnchantedMazeFactory: MazeFactory {
    func makeDoor(_ r1: EnchantedRoom, _ r2: EnchantedRoom) -> DoorNeedingSpell {
        return DoorNeedingSpell(r1: r1, r2: r2)
    }
    
    func makeRoom(_ n: Int) -> EnchantedRoom {
        return EnchantedRoom(n, spell: Spell())
    }
}

var enchantedMazeFactory = EnchantedMazeFactory()
var enchantedMaze = MazeGame.createMaze(mazeFactory: enchantedMazeFactory)
print(enchantedMaze)


/*:
 接下来，我们又接到一个新的需求，我们需要一个有炸弹💣的房间，如果炸弹💣爆炸则会炸毁房间的墙。
 */
//: 构建 RoomWithABomb 表示有炸弹的房间
struct RoomWithABomb: RoomType {
    var roomNo: Int
    var sides: [MapSite?] = [nil, nil, nil, nil]
    var isBombe: Bool
    
    init(_ n: Int, isBombe: Bool) {
        roomNo = n
        self.isBombe = isBombe
    }
}

extension RoomWithABomb: CustomStringConvertible {
    var description: String {
        return "RoomWithABomb Bombe is \(isBombe)"
    }
}

//: 构建 BombedWall 表示被炸毁的墙
struct BombedWall: WallType {
    var isBombed: Bool
    
    init(_ isBombe: Bool) {
        self.isBombed = isBombe
    }
}

extension BombedWall: CustomStringConvertible {
    var description: String {
        return "BombedWall Bombe is \(isBombed)"
    }
}

//: 构建炸弹迷宫的工厂
struct BombedMazeFactory: MazeFactory {
    func makeWall() -> BombedWall {
        return BombedWall(false)
    }
    
    func makeRoom(_ n: Int) -> RoomWithABomb {
        return RoomWithABomb(n, isBombe: false)
    }
    
    func makeDoor(_ r1: RoomWithABomb, _ r2: RoomWithABomb) -> Door {
        return Door(r1: r1, r2: r2)
    }
}

var bombedMazeFactory = BombedMazeFactory()
var bombedMaze = MazeGame.createMaze(mazeFactory: bombedMazeFactory)
print(bombedMaze)
