//
//  Resolution.swift
//  resolution
//
//  Created by Johnny Good on 8/11/20.
//  Copyright © 2020 Johnny Good. All rights reserved.
//

import Foundation

public class Resolution {
    
    private var providerUrl: String;
    private let services: [NamingService];
    
    init(providerUrl: String, network: String) throws {
        self.providerUrl = providerUrl;
        let cns = try CNS(network: network, providerUrl: providerUrl);
        self.services = [cns];
    }
    
    public func namehash(domain: String) throws -> String {
        let preparedDomain = prepare(domain: domain);
        return try getServiceOf(domain: preparedDomain).namehash(domain: preparedDomain)
    }
    
    public func owner(domain: String) throws -> String {
        let preparedDomain = prepare(domain: domain);
        return try getServiceOf(domain: preparedDomain).owner(domain: preparedDomain);
    }
    
    private func getServiceOf(domain: String) throws -> NamingService  {
        guard let service = services.first(where: {$0.isSupported(domain: domain)}) else {
            throw ResolutionError.UnsupportedDomain;
        }
        return service;
    }
    
    private func prepare(domain: String) -> String {
        return domain.lowercased()
    }
    
}
