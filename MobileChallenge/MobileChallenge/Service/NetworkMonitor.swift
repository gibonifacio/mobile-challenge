//
//  NetworkMonitor.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 06/02/25.
//

import Foundation
import Network

class NetworkMonitor {
    
    
    // monitora o status da rede
    let monitor = NWPathMonitor()
    var statusMonitor: Bool = true
    
    func checkConnection() async -> Bool{
        
        // pausa e espera ate o codigo ser executado
        return await withCheckedContinuation { continuation in
            // criado para executar o monitoramento em uma thread secundaria
            let queue = DispatchQueue(label: "Monitor")
            monitor.start(queue: queue)
            
            monitor.pathUpdateHandler = { path in // sempre que houver mudanca na conexao sera chamado
                if path.status == .satisfied {
                    self.statusMonitor = true
                    print("conectado")
                } else {
                    self.statusMonitor = false
                    print("desconectado")

                }
                // quando receber a conexao ele retorna o valor do status
                continuation.resume(returning: self.statusMonitor)
            }
            
            
        }
        
    }
    
}
