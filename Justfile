help:
    just -l

gen_protoc_swift:
    mkdir -p client/swift/Sources/Generated
    protoc --swift_out=client/swift/Sources/Generated \
        --grpc-swift_out=client/swift/Sources/Generated \
        proto/basic.proto
    mv client/swift/Sources/Generated/proto/*.swift client/swift/Sources/Generated/
    rmdir client/swift/Sources/Generated/proto

gen_protoc_go:
    mkdir -p backend/go
    protoc --go_out=backend/go --go_opt=paths=source_relative \
        --go-grpc_out=backend/go --go-grpc_opt=paths=source_relative \
        proto/basic.proto

grpcurl_test:
    grpcurl -plaintext -d '{"id": 2}' localhost:8080 PersonService/GetPerson


# Build the Swift client
swift-build:
    cd client/swift && swift build

# Build the Go server
go-build:
    cd backend/go && go build -o ../../server main.go

# # Generate Go protobuf stubs
# go-proto-gen:
#     cd backend/go && protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative ../../proto/basic.proto

# Generate Swift protobuf stubs (will be done by the Swift build plugin)
# swift-proto-gen:
#     cd proto && protoc --swift_out=../client/swift/Sources basic.proto
