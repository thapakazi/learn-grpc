# 🚀 Learn gRPC

Simple gRPC application with Go backend and Swift client.

## 🏗️ Structure

```
learn-grpc/
├── 🗄️  backend/go/      # Go gRPC server
├── 📱 client/swift/     # Swift gRPC client
├── 📋 proto/           # Protocol Buffer definitions
└── 🛠️  Justfile        # Build commands
```

## ⚡ Quick Start

### Generate Proto Stubs
```bash
just gen_protoc_go     # Generate Go stubs
just gen_protoc_swift  # Generate Swift stubs
```

### Build & Run
```bash
# Build Go server
just go-build

# Build Swift client
just swift-build

# Start Go server (in one terminal)
./server

# Run Swift client (in another terminal)
./client/swift/.build/arm64-apple-macosx/debug/PersonGRPCClient
```

## 🎯 Features

- ✅ Go gRPC server with person service
- ✅ Swift gRPC client with async/await
- ✅ Automated code generation via Justfile
- ✅ Single source of truth for proto definitions

## 🧪 Test with grpcurl

```bash
just grpcurl_test
```

---
*Built with gRPC-Swift 2.0 and Go* 🐹