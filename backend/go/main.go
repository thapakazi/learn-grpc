package main

import (
	"context"
	"log"
	"net"

	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"google.golang.org/grpc/reflection"
	
	// Import the generated protobuf package.
	//pb "github.com/thapakazi/learn-grpc/backend/go/proto"
	pb "github.com/thapakazi/learn-grpc/backend/go/proto"
)

const (
	port = ":8080"
)

// server is used to implement person.PersonServiceServer.
type server struct {
	pb.UnimplementedPersonServiceServer
	people map[int32]*pb.Person // In-memory data store
}

// NewServer creates a new server instance with mock data.
func NewServer() *server {
	s := &server{
		people: make(map[int32]*pb.Person),
	}
	s.people[1] = &pb.Person{Id: 1, Name: "Alice", Email: "alice@example.com"}
	s.people[2] = &pb.Person{Id: 2, Name: "Bob", Email: "bob@example.com"}
	s.people[42] = &pb.Person{Id: 42, Name: "Grace", Email: "grace@example.com"}
	return s
}

// GetPerson implements person.PersonServiceServer.
func (s *server) GetPerson(ctx context.Context, in *pb.PersonRequest) (*pb.Person, error) {
	log.Printf("Received request for person with ID: %d", in.Id)
	
	if person, ok := s.people[in.Id]; ok {
		return person, nil
	}

	// Return a gRPC error if the person is not found.
	return nil, status.Errorf(codes.NotFound, "Person with ID %d not found", in.Id)
}

func main() {
	// Create a TCP listener on the specified port.
	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	
	// Create a new gRPC server.
	grpcServer := grpc.NewServer()
	
	// Register our service implementation with the gRPC server.
	pb.RegisterPersonServiceServer(grpcServer, NewServer())
	// Register reflection service for debugging
	reflection.Register(grpcServer)


	
	log.Printf("Server listening on %v", lis.Addr())
	
	// Start the server in a blocking fashion.
	if err := grpcServer.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
