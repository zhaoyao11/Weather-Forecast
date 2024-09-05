import {getWeatherUtil} from '../util/GetWeatherUtil'
import {GetGeographyUtil} from '../util/GetGeographyUtil'
import dataPreferences from '@ohos.data.preferences'
import promptAction from '@ohos.promptAction';
import { router } from '@kit.ArkUI';

@Component
export struct citymanageritem{

  areaCode:string = ''
  currentIndex:number = 0;
  @StorageLink("ClickIndex") ClickIndex:number = 0;
  @StorageLink("SelectedCitys") SelectedCitys:string[]=[] //已添加城市的城市代码
  @State city:string = ''
  @State text:string = ''
  @State maxtemp:string = ''
  @State mintemp:string = ''
  @State currenttemp:string = ''

  aboutToAppear(): void {
    console.log('小组件中的areacode:'+this.areaCode)
      new getWeatherUtil().getWeather(this.areaCode)
        .then((data)=>{
          this.maxtemp = data.daily[0].tempMax
          this.mintemp = data.daily[0].tempMin
          this.text = data.daily[0].textDay
        })
      new GetGeographyUtil().getgeography(this.areaCode)
        .then((data)=>{
          this.city = data.location[0].name
        })

    new getWeatherUtil().getNowWeather(this.areaCode)
      .then((data)=>{
        this.currenttemp = data.now.temp
      })

    console.log('小组件中的city:'+this.city)
    console.log('小组件中的text:'+this.text)
    console.log('小组件中的maxtemp:'+this.maxtemp)
    console.log('小组件中的mintemp:'+this.mintemp)
    console.log('小组件中的currenttemp:'+this.currenttemp)
  }

  build() {
    //List滑动部分
    Row(){
      Column() {
        Text(this.city)
          .fontWeight(FontWeight.Bold)
          .fontSize(24)
          .fontColor(Color.White)
          .margin({left:-10})

        Text(`${this.text}  ${this.maxtemp}°/${this.mintemp}°`)
          .fontSize(20)
          .fontColor(Color.White)
          .margin({  left: 20 })
          .width(130)
      }

      Text(`${this.currenttemp}°`)
        .fontSize(45)
        .fontColor(Color.White)
        .width('80')
        .margin({left:60})

    }.width('90%')
    .height(90)
    .borderRadius(20)
    .backgroundColor(Color.Black)
    .margin({top:20,left:17})
    .onClick(()=> {
      console.log('该城市的代码为：'+this.areaCode)
      console.log('该城市的代码在数组index为：'+this.currentIndex);
      /*this.ClickIndex = this.currentIndex;
      console.log('该城市的代码在数组index为：'+this.ClickIndex.toString());
      router.pushUrl({url:'pages/Index'})*/
      AlertDialog.show({
        title: '删除地区天气',
        message: '是否删除该地区天气？',
        autoCancel: true,
        alignment: DialogAlignment.Center,
        primaryButton: {
          value: '删除',
          fontColor: Color.Red,
          action: () => {
            for(let i =0;i<this.SelectedCitys.length;i++){
              if(this.SelectedCitys[i] == this.areaCode){
                this.SelectedCitys.splice(i,1)
                console.log('该城市删除成功')
                //数据持久化
                dataPreferences.getPreferences(getContext(this),"citys",(err,preferences)=>{
                  preferences.put("citys", this.SelectedCitys,(err)=>{
                    if(err){
                      console.log('保存到首选项出错')
                      return
                    }
                  })
                  //刷新数据
                  preferences.flush((err)=>{
                    if(err){
                      console.log('刷新首选项出错')
                      return
                    }
                  })
                  promptAction.showToast({message:"删除成功",duration:100});
                })

              }
              else{
                continue
              }
            }
          }
        },
        secondaryButton: {
          value: '取消',
          action: () => {
            console.log('取消添加')
          }
        },
      })
    })

  }
}
