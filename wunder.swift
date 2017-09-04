import Foundation

// This algorithm lazily creates a table of results for each size of raw
// stone. We know that the best(size) is the best result of
// trying each of the cuts, and adding best(size - current_cut_size).

class Stone {
    var cuts : Array<Dictionary<String, Int>>
    var chunks : Dictionary<Int, Chunk> = [:]
    var rawChunks : Array<Int>

    init(cuts: Array<Dictionary<String, Int>>, rawChunks: Array<Int>) {
        self.cuts = cuts
        self.rawChunks = rawChunks
    }

    func total() -> Int {
        return rawChunks.reduce(0, { (sum, chunk) -> Int in
            return sum + value(chunk)
        })
    }

    func value(_ size : Int) -> Int {
        if chunks[size] == nil {
            chunks[size] = Chunk(size: size, stone: self)
        }
        return chunks[size]!.value
    }
}

struct Chunk {
    var value : Int = 0

    init(size: Int, stone: Stone) {
        for cut in stone.cuts {
            if cut["size"]! <= size {
                value = [value, cut["value"]! + stone.value(size - cut["size"]!)].max()!
            }
        }
    }
}

let jsonData = try? Data(contentsOf: URL(fileURLWithPath: "input.json"))
let jsonDict = try! JSONSerialization.jsonObject(with: jsonData!, options: []) as! Dictionary<String, Any?>

let total = jsonDict.reduce(0) { (sum, stoneData: (String, Any)) -> Int in
    let data = stoneData.1 as! Dictionary<String, Array<Any>>
    let cuts = data["cuts"] as! Array<Dictionary<String, Int>>
    let rawChunks = data["rawChunks"] as! Array<Int>

    return sum + Stone(cuts: cuts, rawChunks: rawChunks).total()
}

print(total)
