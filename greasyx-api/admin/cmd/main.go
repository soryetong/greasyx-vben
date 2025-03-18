package main

import (
	_ "greasyx-api/admin/internal/server"

	"github.com/soryetong/greasyx/gina"
	_ "github.com/soryetong/greasyx/modules/casbinmodule"
	_ "github.com/soryetong/greasyx/modules/mysqlmodule"
)

func main() {
	gina.Run()
}
