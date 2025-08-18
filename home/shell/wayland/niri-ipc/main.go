package main

import (
	"net"
	"log"
	"os"
	"io"
	"encoding/json"
	"os/exec"
)

type NiriEventStream struct {
	OverviewOpenedOrClosed struct {
		IsOpen bool `json:"is_open"`
	}
}

func main() {
	niriSocket := os.Getenv("NIRI_SOCKET")
	log.Printf("Connecting to %q...", niriSocket)
	socket, err := net.Dial("unix", os.Getenv("NIRI_SOCKET"))
	if err != nil {
		log.Fatal(err)
	}

	log.Print("Requesting stream...")
	_, err = io.WriteString(socket, `"EventStream"`+"\n")
	if err != nil {
		log.Fatal(err)
	}

	dec := json.NewDecoder(socket)
	dec.DisallowUnknownFields()

	log.Print("Starting to read events")
	for dec.More() {
		var evt NiriEventStream
		if err := dec.Decode(&evt); err != nil {
			continue
		}

		// We are here because the Overview was toggled.
		cmd := exec.Command("pkill", "--signal", "SIGUSR1", "waybar") // TODO: Is it worth the effort to implement `pkill/pidof`?
		if err := cmd.Run(); err != nil {
			log.Print("Unexpected error: %q", err)
		}
	}
}
