//
//  ContentView.swift
//  Demo
//
//  Created by Peter Pan on 2023/8/7.
//

import SwiftUI

struct ContentView: View {
    @State private var resultText = "Testing..."

    var body: some View {
        Text(resultText)
            .padding()
            .onAppear {
                testDrinkController()
            }
    }

    func testDrinkController() {
        Task {
            do {
                let orders = try await OrderController.shared.fetchOrders()
                resultText = "Fetch Orders: Success. Number of Orders: \(orders.count)"
                
                var newOrder = Order(fields: .init(sugar: "half", ice: "less", orderer: "John", drink: "Black Tea", size: "l"))
                let createdOrder = try await OrderController.shared.createOrder(newOrder)
                resultText += "\nCreate Order: Success. Order ID: \(createdOrder.id!)"
                
                newOrder.fields.size = "m"
                let updatedOrder = try await OrderController.shared.updateOrder(createdOrder.id!, with: newOrder)
                resultText += "\nUpdate Order: Success. Order ID: \(updatedOrder.id!)"
                
                let isDeleted = try await OrderController.shared.deleteOrder(updatedOrder.id!)
                resultText += "\nDelete Order: \(isDeleted ? "Success" : "Failure")"

            } catch {
                resultText = "Error: \(error)"
            }
        }
    }
}

#Preview {
    ContentView()
}
