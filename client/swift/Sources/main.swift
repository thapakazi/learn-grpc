import GRPCCore
import GRPCNIOTransportHTTP2
import GRPCProtobuf
import SwiftProtobuf

@main
struct PersonGRPCClient {
    static func main() async throws {
        // Configure the gRPC client transport
        let transport = try HTTP2ClientTransport.Posix(
            target: .ipv4(address: "127.0.0.1", port: 8080),
            transportSecurity: .plaintext
        )

        // Use withGRPCClient to manage the client lifecycle
        try await withGRPCClient(transport: transport) { client in
            // Wrap the raw client with the generated, type-safe PersonService.Client.
            let personServiceClient = PersonService.Client(wrapping: client)

            // Create a request message using the generated struct.
            let request = PersonRequest.with {
                $0.id = 42 // Request person with ID 42
            }

            print("Attempting to get person with ID: \(request.id)...")

            // Call the unary RPC and handle the response.
            do {
                let clientRequest = ClientRequest(message: request)
                let response = try await personServiceClient.getPerson(
                    request: clientRequest,
                    serializer: ProtobufSerializer<PersonRequest>(),
                    deserializer: ProtobufDeserializer<Person>()
                )
                print("--- Successfully received person ---")
                print("ID: \(response.id)")
                print("Name: \(response.name)")
                print("Email: \(response.email)")
            } catch {
                print("RPC failed with error: \(error)")
            }
        }
    }
}
