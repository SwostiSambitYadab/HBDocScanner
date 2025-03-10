//
//  HBDocScanner.swift
//  HBDocScanner
//
//  Created by hb on 06/03/25.
//

import Foundation
import DocumentReader

let REGULA_URL: String = "https://api.regulaforensics.com"

public typealias ScannerCompletion = (_ fields: [String: String], _ portrait: UIImage?, _ url: String?, _ error: (any Error)?) -> Void



final public class HBScanner {

    private init() {}
    public static let shared: HBScanner = .init()
    
    public var functionality: Functionality = .init()
    public var processingMode: OnlineProcessingMode = .manual
    
    
    public func showScanner(scenario: Scenarios, presenter: UIViewController, completion: @escaping ScannerCompletion) {
        
        
        DocReader.shared.functionality.forcePagesCount = 2
        
        let onlineProcessingConfig = DocReader.OnlineProcessingConfig(mode: processingMode == .manual ? .manual : .auto)
        onlineProcessingConfig.serviceURL = REGULA_URL
        onlineProcessingConfig.processParams?.scenario = scenario.description

        let config = DocReader.ScannerConfig(scenario: scenario.description, onlineProcessingConfig: onlineProcessingConfig)
        
        
        DocReader.shared.showScanner(presenter: presenter, config: config) { action, results, error in
            
            if let results {
                
                let image = results.getGraphicFieldImageByType(fieldType: .gf_Portrait)
                
                let url = results.getTextFieldValueByType(fieldType: .ft_URL)
                
                var dict: [String: String] = [:]
                
                for field in results.textResult.fields {
                    print("\(field.fieldName) :: \(field.value)")
                    dict[field.fieldName] = field.value
                }
                completion(dict, image, url, error)
            }
        }
    }
    
    
    public func showScanner(scenario: Scenarios, presenter: UIViewController) async throws -> ([String: String], UIImage?, String?) {
        
        DocReader.shared.functionality.forcePagesCount = 2
        
        let onlineProcessingConfig = DocReader.OnlineProcessingConfig(mode: .manual)
        onlineProcessingConfig.serviceURL = "https://api.regulaforensics.com"
        onlineProcessingConfig.processParams?.scenario = scenario.description

        let config = DocReader.ScannerConfig(scenario: scenario.description, onlineProcessingConfig: onlineProcessingConfig)
        
        do {
            let(_, result) = try await DocReader.shared.showScanner(presenter: presenter, config: config)
            
            let image = result.getGraphicFieldImageByType(fieldType: .gf_Portrait)
            
            let url = result.getTextFieldValueByType(fieldType: .ft_URL)
            
            var dict: [String: String] = [:]
            
            for field in result.textResult.fields {
                print("\(field.fieldName) :: \(field.value)")
                dict[field.fieldName] = field.value
            }
            return (dict, image, url)
            
        } catch {
            throw error
        }
    }
}

public enum OnlineProcessingMode: Int {
    case manual
    case auto
}


public enum Scenarios: CustomStringConvertible {
    
    case MRZ
    case BARCODE
    case LOCATE
    case OCR
    case DOCTYPE
    case MRZ_OR_BARCODE
    case MRZ_OR_LOCATE
    case MRZ_AND_LOCATE
    case BARCODE_AND_LOCATE
    case MRZ_OR_OCR
    case MRZ_OR_BARCODE_OR_OCR
    case LOCATE_VISUAL_AND_MRZ_OR_OCR
    case FULL_PROCESS
    case FULL_AUTH
    case ID3RUS
    case RUS_STAMP
    case OCR_FREE
    case CREDIT_CARD
    case CAPTURE
    case DTC
    
    
    public var description: String {
        switch self {
        case .MRZ:
            return RGL_SCENARIO_MRZ
        case .BARCODE:
            return RGL_SCENARIO_BARCODE
        case .LOCATE:
            return RGL_SCENARIO_LOCATE
        case .OCR:
            return RGL_SCENARIO_OCR
        case .DOCTYPE:
            return RGL_SCENARIO_DOCTYPE
        case .MRZ_OR_BARCODE:
            return RGL_SCENARIO_MRZ_OR_BARCODE
        case .MRZ_OR_LOCATE:
            return RGL_SCENARIO_MRZ_OR_LOCATE
        case .MRZ_AND_LOCATE:
            return RGL_SCENARIO_MRZ_AND_LOCATE
        case .BARCODE_AND_LOCATE:
            return RGL_SCENARIO_BARCODE_AND_LOCATE
        case .MRZ_OR_OCR:
            return RGL_SCENARIO_MRZ_OR_OCR
        case .MRZ_OR_BARCODE_OR_OCR:
            return RGL_SCENARIO_MRZ_OR_BARCODE_OR_OCR
        case .LOCATE_VISUAL_AND_MRZ_OR_OCR:
            return RGL_SCENARIO_LOCATE_VISUAL_AND_MRZ_OR_OCR
        case .FULL_PROCESS:
            return RGL_SCENARIO_FULL_PROCESS
        case .FULL_AUTH:
            return RGL_SCENARIO_FULL_AUTH
        case .ID3RUS:
            return RGL_SCENARIO_ID3RUS
        case .RUS_STAMP:
            return RGL_SCENARIO_RUS_STAMP
        case .OCR_FREE:
            return RGL_SCENARIO_OCR_FREE
        case .CREDIT_CARD:
            return RGL_SCENARIO_CREDIT_CARD
        case .CAPTURE:
            return RGL_SCENARIO_CAPTURE
        case .DTC:
            return RGL_SCENARIO_DTC
        }
    }
}
