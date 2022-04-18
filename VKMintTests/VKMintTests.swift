//
//  VKMintTests.swift
//  VKMintTests
//
//  Created by Тимур Миргалиев on 18.04.2022.
//

import XCTest
@testable import VKMint


class VKMintTests: XCTestCase {
    
    var apiInteractor: MainApiInteractorForSuccessMock!
    var interactor: AuthInteractor!
    var output: AuthInteractorOutputForSuccessMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        output = AuthInteractorOutputForSuccessMock()
        apiInteractor = MainApiInteractorForSuccessMock()
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
    
    func testAuthorizeSuccess() throws {
        // given
        
        
        // when
        interactor.authorize()
        
        // then
        XCTAssertTrue(output.isSuccessful)
    }
}
