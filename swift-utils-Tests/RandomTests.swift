//
//  RandomTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 13/12/2014.
//
//

import UIKit
import XCTest

class RandomTests: XCTestCase {

    func test_random() {
        let inclusiveMaxValue: UInt32 = 10
        let n = 1_000_000
        var minimum: UInt32 = UInt32.max
        var maximum: UInt32 = 0
        var mean: Double = 0
        for i in 0..<n {
            let r = random(inclusiveMaxValue)
            minimum = min(minimum, r)
            maximum = max(maximum, r)
            mean += Double(r)
        }
        mean /= Double(n)
        XCTAssertEqual(minimum, UInt32(0))
        XCTAssertEqual(maximum, inclusiveMaxValue)
        XCTAssertEqualWithAccuracy(mean, 5.0, 0.01)
    }
    
    func test_random_Double() {
        let n = 1_000_000
        var minimum: Double = 1
        var maximum: Double = 0
        var mean: Double = 0
        for i in 0..<n {
            let r: Double = random()
            minimum = min(minimum, r)
            maximum = max(maximum, r)
            mean += r
        }
        mean /= Double(n)
        XCTAssertEqualWithAccuracy(minimum, 0, 0.01)
        XCTAssertEqualWithAccuracy(maximum, 1, 0.01)
        XCTAssertEqualWithAccuracy(mean, 0.5, 0.01)
    }
    
    func test_shuffled() {
        var a = [Int]()
        for i in 0..<1000 {
            a.append(i)
        }
        XCTAssertNotEqual(a, a.shuffled())
        XCTAssertNotEqual(a.shuffled(), a.shuffled())
    }
    
    func test_createHitmap() {
        XCTAssertEqual(createHitmap([1, 1, 1, 1]), [0.25, 0.5, 0.75])
        XCTAssertEqual(createHitmap([3, 1]), [0.75])
        XCTAssertEqual(createHitmap([2, 1, 2])[0], 0.4)
        XCTAssertEqualWithAccuracy(createHitmap([2, 1, 2])[1], 0.6, 0.01)
        XCTAssertEqual(createHitmap([1]), [])
        XCTAssertEqual(createHitmap([]), [])
    }
    
    func test_findBucket() {
        XCTAssertEqual(findBucket([0.25, 0.5, 0.75], 0.0), 0)
        XCTAssertEqual(findBucket([0.25, 0.5, 0.75], 0.2), 0)
        XCTAssertEqual(findBucket([0.25, 0.5, 0.75], 0.25), 0)
        XCTAssertEqual(findBucket([0.25, 0.5, 0.75], 0.3), 1)
        XCTAssertEqual(findBucket([0.25, 0.5, 0.75], 0.6), 2)
        XCTAssertEqual(findBucket([0.25, 0.5, 0.75], 0.8), 3)
        XCTAssertEqual(findBucket([0.25, 0.5, 0.75], 1.2), 3)
        XCTAssertEqual(findBucket([], 0), 0)
    }

    
    func test_randomElement_logic() {
        // this test is 16(!) times faster than test_randomElement due to 'createHitmap'
        let n = 10_000
        var counts = [0, 0, 0, 0, 0]
        let hitmap = createHitmap([1.0, 2.0, 1.0, 4.0, 2.0])
        for _ in 0..<n {
            let i = findBucket(hitmap, random())
            counts[i]++
        }
        XCTAssertEqual(sum(counts), n)
        XCTAssertEqualWithAccuracy(Double(counts[0])/Double(n), 0.10, 0.02)
        XCTAssertEqualWithAccuracy(Double(counts[1])/Double(n), 0.20, 0.02)
        XCTAssertEqualWithAccuracy(Double(counts[2])/Double(n), 0.10, 0.02)
        XCTAssertEqualWithAccuracy(Double(counts[3])/Double(n), 0.40, 0.02)
        XCTAssertEqualWithAccuracy(Double(counts[4])/Double(n), 0.20, 0.02)
    }

    func test_randomElement() {
        // running this test with large n is slow
        // logic is tested in test_randomElement_logic
        let n = 10
        var counts = [0, 0, 0, 0, 0]
        for _ in 0..<n {
            let i = randomElement([0, 1, 2, 3, 4])!
            counts[i]++
        }
        XCTAssertEqual(sum(counts), n)
    }
    
    func test_randomElement_empty() {
        XCTAssertNil(randomElement([Int]()))
    }
}
