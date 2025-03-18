package server

import (
	"greasyx-api/admin/internal/logic"
	"greasyx-api/admin/internal/router"

	"github.com/soryetong/greasyx/gina"
	"github.com/soryetong/greasyx/modules/httpmodule"
	"github.com/spf13/viper"
)

func init() {
	gina.Register(&AdminServer{})
}

type AdminServer struct {
	*gina.IServer

	httpModule httpmodule.IHttp
}

func (self *AdminServer) OnStart() (err error) {
	// 缓存api信息, 方便记录操作日志
	new(logic.SystemApiLogic).CacheApiInfo()

	// 添加回调函数
	self.httpModule.OnStop(self.exitCallback())

	self.httpModule.Init(self, viper.GetString("App.Addr"), 5, router.InitRouter())
	err = self.httpModule.Start()

	return
}

// TODO 添加回调函数, 无逻辑可直接删除这个方法
func (self *AdminServer) exitCallback() *httpmodule.CallbackMap {
	callback := httpmodule.NewStopCallbackMap()
	callback.Append("exit", func() {
		gina.Log.Info("这是程序退出后的回调函数, 执行你想要执行的逻辑, 无逻辑可以直接删除这段代码")
	})

	return callback
}
