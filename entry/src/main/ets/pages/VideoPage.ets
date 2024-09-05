import { router } from '@kit.ArkUI'
import { request } from '@kit.BasicServicesKit'
import http from '@ohos.net.http';

@Entry
@Component
struct VideoCase {

  @State
  speed: number = 1
  controller: VideoController = new VideoController()
  build() {

    Column() {
      Row() {
        Image($r('app.media.returnback'))
          .width(20)
          .margin({ top: 10, left: 10 })
          .onClick(()=>{
            router.back()
          })
      }.width('100%')
      .margin({bottom:20})

      Column({ space: 20 }) {
        Video({
          controller: this.controller,
          currentProgressRate: this.speed,
          src:'https://vod.weathertv.cn/video/2024/8/31/202408311725117123339.mp4'
   //       src: 'https://vd3.bdstatic.com/mda-pmj5ajqd7p4b6pgb/576p/h264/1703044058699262355/mda-pmj5ajqd7p4b6pgb.mp4?auth_key=1703138418-0-0-618ea72b33be241c96c6cff86c06e080&bcevod_channel=searchbox_feed&cr=1&cd=0&pd=1&pt=4&logid=0018430194&vid=9762003448174112444&abtest=all'
        })
          .width('100%')
          .aspectRatio(1.766)
        Slider({
          value: this.speed,
          min: 0.75,
          step: 0.25,
          max: 2,
          style: SliderStyle.InSet
        })
          .showSteps(true)
          .onChange(value => {
            this.speed = value
          })
        Text(this.speed + "倍速").fontSize(14).textAlign(TextAlign.Center).width('100%')
        Row({ space: 20 }) {
          Button("播放")
            .onClick(() => {
              this.controller.start()
            })
          Button("暂停")
            .onClick(() => {
              this.controller.pause()
            })
          Button("移动进度")
            .onClick(() => {
              this.controller.setCurrentTime(30) // 这里的单位为秒
            })
          Button("结束")
            .onClick(() => {
              this.controller.stop()
            })
        }
      }
      .width('100%')

    }.height('100%')
    .width('100%')

  }
}
