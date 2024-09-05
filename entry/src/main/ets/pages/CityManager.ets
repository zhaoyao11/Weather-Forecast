import { citymanageritem} from '../view/CityManagerItem'
import router from '@ohos.router';
import dataPreferences from '@ohos.data.preferences'

@Entry
@Component
struct CityManager {
  @StorageLink("SelectedCitys") SelectedCitys:string[]=[] //已添加城市的城市代码

  aboutToAppear(): void {
    console.log('首选项中的city数组为：'+this.SelectedCitys)

    dataPreferences.getPreferences(getContext(this),"citys",(err,preferences)=>{
      if(err){
        console.log("打开首选项失败");
        return
      }
      preferences.get('citys','',(err,val)=>{
        if(err){
          console.log("读取首选项出错");
        }
        this.SelectedCitys = val as string[]
        console.log('首选项中的citys是：'+val.toString())
      })
    })

  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.returnback'))
          .width(25)
          .height(25)
          .margin({ top: 10, left:10})
          .onClick(()=>{
            router.back();
          })
      }.width('100%')

      Row() {
        Text('城市管理')
          .fontSize(30)
      }.width('100%')
      .margin({top:25,left:30})

      Row(){
        Image($r('app.media.rearch'))
          .width(25)
          .height(25)
          .margin({left:20})

        Text('搜索位置')
          .height(40)
          .layoutWeight(1)
          .margin({left:10})
          .onClick(()=>{
            router.pushUrl({url:'pages/SearchPage'})
          })

      }.width('90%')
      .height(40)
      .backgroundColor(Color.Pink)
      .borderRadius(20)
      .margin({top:30})

      //信息小卡片部分
      List(){
        ForEach(this.SelectedCitys,(item:string,index:number)=>{
          ListItem(){
            citymanageritem({areaCode:item,currentIndex:index})
          }
        })
      }.layoutWeight(1)

    }.width('100%')
    .height('100%')
  }
}