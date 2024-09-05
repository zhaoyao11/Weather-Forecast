import { NowAreaComponent } from '../view/NowAreaComponent'

@Component

export struct picuturecomponent{

  @Consume currenttext:string
  item:string = ''

  build() {
    Stack(){
      if(this.currenttext.includes('雷')) {
        Image($r('app.media.storm'))
          .width('100%')
          .height('100%')
      }
      else if(this.currenttext.includes('晴')) {
        Image($r('app.media.sunny'))
          .width('100%')
          .height('100%')
      }
      else if(this.currenttext.includes('雪')) {
        Image($r('app.media.snowy'))
          .width('100%')
          .height('100%')
      }
      else if(this.currenttext=='多云'){
        Image($r('app.media.cloudy'))
          .width('100%')
          .height('100%')
          .onClick(()=>{
            console.log('点击到了图片')
          })
      }
      else if(this.currenttext=='阴'){
        Image($r('app.media.cloudy_nosun'))
          .width('100%')
          .height('100%')
      }
      else if(this.currenttext.includes('雨')){
        Image($r('app.media.rainy'))
          .width('100%')
          .height('100%')
      }
      NowAreaComponent({location_code:this.item})

    }.height('100%')
       .width('100%')
       .alignContent(Alignment.TopStart)
  }
}