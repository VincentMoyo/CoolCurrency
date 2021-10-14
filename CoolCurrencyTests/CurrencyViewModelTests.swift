//
//  CurrencyViewModelTest.swift
//  CoolCurrencyTests
//
//  Created by Vincent Moyo on 2021/10/11.
//

import XCTest
@testable import CoolCurrency

class CurrencyViewModelTests: XCTestCase {
    
    private var implementationUnderTests: CurrencyViewModel!
    private var mockDelegate: MockDelegate!
    private var mockRepository: MockRepository!
    
    override func setUp() {
        mockDelegate = MockDelegate()
        mockRepository = MockRepository()
        implementationUnderTests = CurrencyViewModel(repository: mockRepository,
                                                     delegate: mockDelegate)
    }
    
    func testFetchCurrency() {
        setUpMockResponse()
        XCTAssertEqual(14, implementationUnderTests.currencyList.values.count)
        XCTAssert(mockDelegate.refreshCalled)
    }
    
    func testFetchCurrencyFailure() {
        implementationUnderTests.fetchCurrencyList(for: "ZAR")
        XCTAssert(mockDelegate.showUserErrorCalled)
    }
    
    func testConvertCurrencyToCode() {
        XCTAssertEqual("ZAR", implementationUnderTests.convertCurrencyToCode(for: "Rand"))
    }
    
    func testTableView() {
        setUpMockResponse()
        XCTAssertEqual("Rand", implementationUnderTests.setUpTableViewModel(at: 1)?.currencyName)
    }
    
    func setUpMockResponse() {
        mockRepository.response = .success(mockData)
        implementationUnderTests.fetchCurrencyList(for: "ZAR")
    }
    
    private var mockData: CurrencyResponseModel {
        CurrencyResponseModel(response: Response(base: "ZAR",
                                                 rates: Rates(unitedStatesDollar: 1.1,
                                                              euro: 1.1,
                                                              indianRupee: 1.1,
                                                              bostwanaPula: 1.1,
                                                              canadianDollar: 1.1,
                                                              ghanaCedi: 1.1,
                                                              greatBritishPound: 1.1,
                                                              japaneseYen: 1.1,
                                                              russianRuble: 1.1,
                                                              chineseYuan: 1.1,
                                                              southAfricanRand: 1.1,
                                                              unitedArabDirham: 1.1,
                                                              brazilianReal: 1.1,
                                                              australianDollar: 1.1)))
    }
    
    class MockDelegate: CurrencyViewModelDelegate {
        
        var refreshCalled = false
        var showUserErrorCalled = false
        
        func showUserErrorMessage(error: Error) {
            showUserErrorCalled = true
        }
        
        func bindViewModel(_ currencyViewModel: CurrencyViewModel) {
            refreshCalled = true
        }
    }
    
    class MockRepository: CurrencyRepositable {
        
        var response: Result<CurrencyResponseModel, Error> = .failure(MyErrors.retrieveError("error"))
        
        func performCurrencyRequest(for baseCurrency: String, completion: @escaping ListCurrencyResponseModel) {
            completion(response)
        }
    }
}
