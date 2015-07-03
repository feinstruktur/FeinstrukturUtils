//
//  IndexSetTests.swift
//  FeinstrukturUtils
//
//  Created by Sven A. Schmidt on 03/07/2015.
//
//

import XCTest
import Nimble


class IndexSetTests: XCTestCase {

    func test_init_array() {
        let i = IndexSet([0,2,4])
        let g = i.generate()
        expect(g.next()) == 0
        expect(g.next()) == 2
        expect(g.next()) == 4
        expect(g.next()).to(beNil())
    }


    func test_init_array_duplicates() {
        let i = IndexSet([0,1,1,2])
        let g = i.generate()
        expect(g.next()) == 0
        expect(g.next()) == 1
        expect(g.next()) == 1
        expect(g.next()) == 2
        expect(g.next()).to(beNil())
    }



    func test_init_range() {
        let i = IndexSet(2..<5)
        let g = i.generate()
        expect(g.next()) == 2
        expect(g.next()) == 3
        expect(g.next()) == 4
        expect(g.next()).to(beNil())
    }


    func test_addIndex() {
        var i = IndexSet(2..<5)
        i.addIndex(1)
        let g = i.generate()
        expect(g.next()) == 2
        expect(g.next()) == 3
        expect(g.next()) == 4
        expect(g.next()) == 1
        expect(g.next()).to(beNil())
    }

}

