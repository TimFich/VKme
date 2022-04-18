//
//  TestOfFailerAuth.swift
//  VKMintTests
//
//  Created by Тимур Миргалиев on 18.04.2022.
//

import XCTest
@testable import VKMint


class TestOfFailerAuth: XCTestCase {
    
    var apiInteractor: MainApiInteractorForFailerMock!
    var interactor: AuthInteractor!
    var output: AuthInteractorOutputForFailerMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        output = AuthInteractorOutputForFailerMock()
        apiInteractor = MainApiInteractorForFailerMock()
        interactor = AuthInteractor()
        interactor.output = output
        interactor.mainApiInteractor = apiInteractor
    }

    override func tearDownWithError() throws {
        apiInteractor = nil
        output = nil
        apiInteractor = nil
        
        try super.tearDownWithError()
    }
    
    func testAuthorizeaFailer() throws {
        // given
        
        
        // when
        interactor.authorize()
        
        // then
        XCTAssertFalse(output.isSuccessful)
    }
}
