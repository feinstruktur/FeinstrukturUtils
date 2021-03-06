//
//  RandomTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 13/12/2014.
//
//

import XCTest
import Nimble


class RandomTests: XCTestCase {

    func test_random() {
        let inclusiveMaxValue: UInt32 = 10
        let n = 1_000_000
        var minimum: UInt32 = UInt32.max
        var maximum: UInt32 = 0
        var mean: Double = 0
        for _ in 0..<n {
            let r = random(inclusiveMaxValue)
            minimum = min(minimum, r)
            maximum = max(maximum, r)
            mean += Double(r)
        }
        expect(minimum) == 0
        expect(maximum) == inclusiveMaxValue
        mean /= Double(n)
        expect(mean) == 5 ± 0.01
    }
    
    func test_random_Double() {
        let n = 1_000_000
        var minimum: Double = 1
        var maximum: Double = 0
        var mean: Double = 0
        for _ in 0..<n {
            let r: Double = random()
            minimum = min(minimum, r)
            maximum = max(maximum, r)
            mean += r
        }
        expect(minimum) == 0 ± 0.01
        expect(maximum) == 1 ± 0.01
        mean /= Double(n)
        expect(mean) == 0.5 ± 0.01
    }
    
    func test_random_from_to() {
        let n = 1_000_000
        let from = 3.0
        let to = 7.0
        var minimum = to
        var maximum = from
        var mean: Double = 0
        for _ in 0..<n {
            let r = random(from, to: to)
            minimum = min(minimum, r)
            maximum = max(maximum, r)
            mean += r
        }
        expect(minimum) == 3 ± 0.01
        expect(maximum) == 7 ± 0.01
        expect(minimum) >= from
        expect(maximum) < to
        mean /= Double(n)
        expect(mean) == 5.0 ± 0.01
    }
    
    func test_shuffled() {
        var a = [Int]()
        for i in 0..<1000 {
            a.append(i)
        }
        expect(a) != a.shuffled()
        expect(a.shuffled()) != a.shuffled()
    }
    
    func test_createHitmap() {
        expect(createHitmap([1, 1, 1, 1])) ≈ [0.25, 0.5, 0.75]
        expect(createHitmap([3, 1])) ≈ [0.75]
        expect(createHitmap([2, 1, 2])) ≈ [0.4, 0.6]
        expect(createHitmap([1])) == []
        expect(createHitmap([])) == []
    }
    
    func test_findBucket() {
        expect(findBucket([0.25, 0.5, 0.75], value: 0.0)) == 0
        expect(findBucket([0.25, 0.5, 0.75], value: 0.2)) == 0
        expect(findBucket([0.25, 0.5, 0.75], value: 0.25)) == 0
        expect(findBucket([0.25, 0.5, 0.75], value: 0.3)) == 1
        expect(findBucket([0.25, 0.5, 0.75], value: 0.6)) == 2
        expect(findBucket([0.25, 0.5, 0.75], value: 0.8)) == 3
        expect(findBucket([0.25, 0.5, 0.75], value: 1.2)) == 3
        expect(findBucket([], value: 0)) == 0
    }

    
    func test_randomElement_logic() {
        // this test is 16(!) times faster than test_randomElement due to 'createHitmap'
        let n = 10_000
        var counts = [0, 0, 0, 0, 0]
        let hitmap = createHitmap([1.0, 2.0, 1.0, 4.0, 2.0])
        for _ in 0..<n {
            let i = findBucket(hitmap, value: random())
            counts[i] += 1
        }
        expect(sum(counts)) == n
        expect(Double(counts[0])/Double(n)) == 0.10 ± 0.02
        expect(Double(counts[1])/Double(n)) == 0.20 ± 0.02
        expect(Double(counts[2])/Double(n)) == 0.10 ± 0.02
        expect(Double(counts[3])/Double(n)) == 0.40 ± 0.02
        expect(Double(counts[4])/Double(n)) == 0.20 ± 0.02
    }

    func test_randomElement() {
        // running this test with large n is slow
        // logic is tested in test_randomElement_logic
        let n = 10
        var counts = [0, 0, 0, 0, 0]
        for _ in 0..<n {
            let i = randomElement([0, 1, 2, 3, 4])!
            counts[i] += 1
        }
        expect(sum(counts)) == n
    }
    
    func test_randomElement_empty() {
        expect(randomElement([Int]())).to(beNil())
    }

}
