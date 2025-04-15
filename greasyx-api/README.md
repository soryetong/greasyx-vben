<h1 align="center">GreasyX Admin API</h1>

<p align="center"> 它基于 Gin，使用传统的 `Router` + `Handler `+ `Logic` 实现</p>

## 介绍

底层使用的是我自己常用的脚手架，详见 [greasyx](https://github.com/soryetong/greasyx)

**注意 📢：你完全可以不用我这个脚手架，只需几步，你就可以快速移植到你自己的项目中**

-   逻辑阅读从 `admin/internal/router/enter.go` 开始

<br>

## 快速移植到自己的项目中

1. 把 `docs` 目录下的 SQL 导入到你的数据库中

2. 复制 `admin/internal` 、`/models` 目录到你自己的项目中，并删除 `internal` 目录下的 `server` 目录

3. 全项目内搜索 `greasyx-api` 并替换为你的 `package name`

4. 全项目内搜索 `gina.GMySQL()` 并替换为你的 `Db链接`

5. 在你的项目中加载路由 `router.InitRouter()`, 记得自行实现中间件逻辑

6. `go mod tidy`
