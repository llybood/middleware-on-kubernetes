# 说明
skywalking的部署分为服务端和客户端,服务端有2个组件,一个是oap-server,一个是ui

客户端部署需要以sidecar的形式注入到应用容器中,当前项目提供了一个demo,在yaml/agent/路径下,可以作为参考

# 安装skywalking
`sh install_skywalking.sh`
# 卸载skywalking
`sh uninstall_skywalking.sh`
# skywalking集群自定义配置修改
`vim yaml/oap-server/deployment.yml`
`vim yaml/ui/deployment.yml`
