import { citymanageritem} from '../view/CityManagerItem'
import router from '@ohos.router';
import {GetGeographyUtil} from '../util/GetGeographyUtil'
import {foregeography} from '../viewmodel/foregeography'
import {geography} from '../viewmodel/geography'
import {searchlistItem} from '../model/SearchList'

@Entry
@Component
struct SearchPage {
  @State city_name:string = ''

  //模糊搜索的十个地名
  @State Array_Citys:geography[] = []

  GeographyInfo= new GetGeographyUtil().getgeography(this.city_name)

  build() {
    Column() {
      Row(){
        Image($r('app.media.returnback'))
          .width(25)
          .onClick(()=>{
            router.back()
          })
      }
      .width('100%')
      .margin({top:10,left:10})

      Row() {
        Image($r('app.media.rearch'))
          .width(25)
          .height(25)
          .margin({ left: 20 })

        TextInput()
          .onChange((value: string) => {
            this.city_name = value
            this.GeographyInfo = new GetGeographyUtil().getgeography(this.city_name)
            this.GeographyInfo.then((data) => {
              this.Array_Citys = data.location
              console.log('地理位置为：' + this.Array_Citys[0].name)
              console.log('地理位置为：' + this.Array_Citys[1].name)
              console.log('地理位置一共有' + this.Array_Citys.length)
            })
          })
      }

      List() {
        ForEach(this.Array_Citys,(item:geography)=>{
          ListItem(){
            searchlistItem({array:item})
          }
        })

      }

    }.height('100%')
    .width('100%')


  }
}