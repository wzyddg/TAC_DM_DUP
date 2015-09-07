# TAC-DM
TAC-DeviceManagement

### For the Back-End guys:
* All the data you have to change with the 
like this:

```swift
// MARK:- TODO: Here
    func dealConfirmAction (alert:UIAlertAction!)
    {
        println("action here")
    }
``` 

* Setting model use the same scene with diffrent controller more than twice, be careful , any problems can contact me.

Harold Liu



# Back-End Detail
所有传给服务器的信息和传回的信息都用[]（半角的方括号）来封锁两端，若没有后半]则认为信息不完整，需要再向对方索取，然后和之前的信息拼接起来。

传入传出的字符，如无特殊说明都是半角符号。

客户端应该每隔一段时间自动向服务器索取新的数据。

###1.获取设备列表

传给服务器:[1|设备种类]   
现阶段支持的设备种类有如下:book,umbrella,apple这三种，全小写，任何不是这三种的字符串都会被认为是无效而传回空:[]
eg:[1|apple]

传回客户端:[设备id,设备名称,设备描述,设备类型,设备数量,剩余数量|设备id,设备名称,设备描述...]
eg:[1,iPad#1,TAC iPad,apple,1,1|4,iPad Air#4,TAC iPad,apple,1,1]
用|做不同条目间的分隔符，下同。
传回的数据只包含可借用【数量大于1】且在数据库内有登记的物品。


###2.获取历史记录（过去30天内归还的和未归还的）

传给服务器:[2]

传回客户端:[记录Id,借用者名字,借用者电话,借用物Id,借用物名称,借用物描述,借用日期,归还日期,借用数量|记录Id,借用者名字,借用者电话...]
eg:[7,全栈攻城狮薛哥,13194949494,1,iPad#1,TAC iPad,1434910440,1440920440,1|4,安卓红,15268686868,4,iPad Air#4,TAC iPad,1435210440,0,1]
每条借用记录有自己的Id，若借用的是库中没有的物品，借用物Id会为空。
归还时间为0代表未归还。
时间都用时间戳的方式进行传递。


###3.通过物品Id获取单条物品信息

传给服务器:[3|设备Id]   
eg:[3|1]

传回客户端:[设备id,设备名称,设备描述,设备类型,设备数量,剩余数量]
eg:[1,iPad#1,TAC iPad,apple,1,1]
与1略有重复，备用


###4.通过记录Id获取单条记录

传给服务器:[4|记录Id]
eg:[3|7]

传回客户端:[记录Id,借用者名字,借用者电话,借用物Id,借用物名称,借用物描述,借用日期,归还日期,借用数量]
eg:[7,全栈攻城狮薛哥,13194949494,1,iPad#1,TAC iPad,1434910440,1440920440,1]
与2略有重复，备用


###5.借用物品

传给服务器:[5|借用者名字,借用者电话,借用物Id,借用物名称,借用物描述,借用数量]
eg1:[5|全栈攻城狮薛哥,13194949494,1,,,1]
eg2:[5|全栈攻城狮薛哥,13194949494,,羽毛球,一个长得很可爱的羽毛球,1]
在数据库库中有的物品可以只写物品Id【写了Id的话名称和描述就不会看了】
在数据库中没有的物品不写Id，名称和描述一定要写

传给客户端:[借用记录创建成功与否]
eg:[1]
1代表成功，0代表失败
不论成功与否客户端最好都回调进行数据更新


###6.归还物品

传给服务器:[6|记录Id]
eg:[6|7]

传给客户端:[物品归还成功与否]
eg:[0]
1代表成功，0代表失败
不论成功与否客户端最好都回调进行数据更新


###7.管理员登录

传给服务器:[7|密码]
eg:[7|123]

传给客户端:[登录成功与否]
eg:[0]
1代表成功，0代表失败
成功则允许进入设置，不成功则提示登录失败或密码错误


###8.管理员级别获取设备列表

传给服务器:[8|设备种类]   
现阶段支持的设备种类有如下:book,umbrella,apple这三种，全小写，任何不是这三种的字符串都会被认为是无效而传回空:[]
eg:[8|apple]

传回客户端:[设备id,设备名称,设备描述,设备类型,设备数量,剩余数量|设备id,设备名称,设备描述...]
eg:[1,iPad#1,TAC iPad,apple,1,1|4,iPad Air#4,TAC iPad,apple,1,1]

传回的数据包含所有在数据库内有登记的物品。


###9.修改设备剩余数量

传给服务器:[9|设备Id,新的数量]
eg:[9|1,5]

传给客户端:[修改成功与否]
eg:[0]
1代表成功，0代表失败
不论成功与否客户端最好都回调进行数据更新



