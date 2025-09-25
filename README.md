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
# Start Go server (in one terminal)
just run-server

# Run Swift client (in another terminal)
just run-client
```

### Manual Build (optional)
```bash
just go-build      # Build Go server
just swift-build   # Build Swift client
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