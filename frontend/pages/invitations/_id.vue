<template>
  <el-main class="show_invite_wrapper">
    <el-row style="height: 100%;">
      <el-col class="left content" :sm="12" :lg="8">
        <el-row style="height: 100%;">
          <el-col :span="24" :xs="12" class="inviter">
            <el-row style="height: 100%;">
              <el-col class="user flex-center" :sm="21" :lg="24">
                <el-avatar :src="inviter.image.url" :size="150"></el-avatar>
                <p style="font-size: 38px; font-weight: bold;color: #eee;">{{ inviter.name }}</p>
              </el-col>
              <el-col class="title" :sm="3" :lg="24">
                <p>SENDER</p>
              </el-col>
            </el-row>
          </el-col>
          <el-col :span="24" :xs="12" class="invited">
              <el-col class="user flex-center" :sm="21" :lg="24">
                <el-avatar :src="invited.image.url" :size="150"></el-avatar>
                <p style="font-size: 38px; font-weight: bold;color: #eee;">{{ invited.name }}</p>
              </el-col>
              <el-col class="title" :sm="3" :lg="24">
                <p>RECIPIENT</p>
              </el-col>
          </el-col>
        </el-row>
      </el-col>
      <el-col class="center content" :sm="12" :lg="8">
        <div class="messages">
          <el-timeline style="z-index: 0;">
            <el-timeline-item timestamp="2018/4/12" placement="top">
              <el-card>
                <h4>Update Github template</h4>
                <p>Tom committed 2018/4/12 20:46</p>
              </el-card>
            </el-timeline-item>
            <el-timeline-item timestamp="2018/4/3" placement="top">
              <el-card>
                <h4>Update Github template</h4>
                <p>Tom committed 2018/4/3 20:46</p>
              </el-card>
            </el-timeline-item>
            <el-timeline-item timestamp="2018/4/3" placement="top">
              <el-card>
                <h4>Update Github template</h4>
                <p>Tom committed 2018/4/3 20:46</p>
              </el-card>
            </el-timeline-item>
            <el-timeline-item timestamp="2018/4/3" placement="top">
              <el-card>
                <h4>Update Github template</h4>
                <p>Tom committed 2018/4/3 20:46</p>
              </el-card>
            </el-timeline-item>
            <el-timeline-item timestamp="2018/4/2" placement="top">
              <el-card>
                <h4>Update Github template</h4>
                <p>Tom committed 2018/4/2 20:46</p>
              </el-card>
            </el-timeline-item>
            <el-timeline-item timestamp="2018/4/2" placement="top">
              <el-card>
                <h4>Update Github template</h4>
                <p>Tom committed 2018/4/2 20:46</p>
              </el-card>
            </el-timeline-item>
            <el-timeline-item timestamp="2018/4/2" placement="top">
              <el-card>
                <h4>Update Github template</h4>
                <p>Tom committed 2018/4/2 20:46</p>
              </el-card>
            </el-timeline-item>
          </el-timeline>
          <el-input type="textarea" style="margin-bottom: 30px;" :rows="4"></el-input>
          <el-button>Comment</el-button>
        </div>
      </el-col>
      <el-col class="right content" :sm="24" :lg="8">
        <el-row style="height: 100%;">
          <el-col :xs="24" :sm="12" :lg="24" class="calender">
            <p style="text-align:center;font-size: 25px;font-weight:bold;padding-top: 50px;">The date is the {{ invitation.invite_date }}</p>
            <el-calendar  v-model="dateValue">
            </el-calendar>
          </el-col>
          <el-col :xs="24" :sm="12" :lg="24" class="shop">
            <el-tabs v-model="activeName">
              <el-tab-pane style="color: #eee" label="Shop MAP" name="first">
                <GmapMap
                  :center="{ lat: 35.681167, lng: 139.767052 }"
                  :zoom="15"
                  map-type-id="terrain"
                  style="width: 100%; height: 450px;"
                >
                  <GmapMarker
                    :position="{ lat: 35.681167, lng: 139.767052 }"
                    :clickable="true"
                    :draggable="true"
                  />
                </GmapMap>
              </el-tab-pane>
              <el-tab-pane  style="color: #eee" label="Shop INFO" name="second">Config</el-tab-pane>
            </el-tabs>
            <div class="action flex-center">
              <el-radio-group v-model="radio1">
                <el-radio :label="2">OK ! Let's go eat.</el-radio>
                <el-radio :label="3">I'm sorry. I can't go.</el-radio>
              </el-radio-group>
            </div>
          </el-col>
        </el-row>
      </el-col>
    </el-row>
  </el-main>
</template>
<script>
export default {
  async asyncData({ $axios, params }){
    const baseUrl = process.client ? process.env.browserBaseUrl : process.env.apiBaseUrl
    const data = await $axios.$get(baseUrl + `/api/invitations/${params.id}`)
    console.log(data)
    return {
      invitation: data,
      inviter: data.inviter,
      invited: data.invited,
      dateValue: data.invite_date
    }
  },
  data(){
    return {
      activeName: 'first',
      radio1: '',
    }
  }
}
</script>
<style>
.show_invite_wrapper {
  height: 100vh;
  padding: 0;
}
.show_invite_wrapper .content{
  height: 100%;
}
.show_invite_wrapper .left{
  background: #eea;
}
.show_invite_wrapper .right{
  background: #ccc;
  position: relative;
}
.show_invite_wrapper .right .action{
  position: absolute;
  bottom: 0;
  background: #fff;
  height: 60px;
  width: 100%;
}
.show_invite_wrapper .right{
  background: #ece;
}
.show_invite_wrapper .inviter,
.show_invite_wrapper .invited,
.show_invite_wrapper .calender,
.show_invite_wrapper .shop {
  height: 50%;
}
.show_invite_wrapper .left .title {
  background: rgb(68, 45, 24);
  height: 15%;
}
.show_invite_wrapper .left .title p{
  color: #eee;
  text-align: right;
  font-size: 50px;
  font-weight: bold;
}
.show_invite_wrapper .left .inviter .title{
  border-bottom: 2px solid #eee;
}
.show_invite_wrapper .inviter .user,
.show_invite_wrapper .invited .user{
  height: 85%;
  background: rgb(177, 115, 75);
  flex-direction: column;
}
.show_invite_wrapper .invited {
  display: flex;
  flex-direction: column-reverse;
}
.show_invite_wrapper .center .messages {
  overflow-y: scroll;
  height: 100%;
  padding: 30px 20px;
}
.show_invite_wrapper .center .el-timeline {
  padding: 0;
}
.show_invite_wrapper .right .calender{
  border-bottom: 2px solid #ffe;
  background: #ffe;
}
.show_invite_wrapper .right .shop{
  padding-bottom: 80px;
  background: #555;
}
.show_invite_wrapper .right .el-tabs--top{
  height: 100%;
  margin: 0 10px;
}
.show_invite_wrapper .right .el-tabs__content{
  height: 90%;
  overflow-y: hidden;
}
.show_invite_wrapper .right .el-tabs__item {
  color: #eee;
}
.show_invite_wrapper .right .el-calendar-day {
  height: 40px;
  padding: 2px;
}
.show_invite_wrapper .right .el-calendar__body {
  padding: 10px;
  background: #ffe;
}
.show_invite_wrapper .right .el-calendar__header {
  background: #ffe;
}
.show_invite_wrapper .right .el-calendar-day span {
  font-size: 10px;
}
@media (min-width: 769px) and (max-width: 1200px) {
  .show_invite_wrapper .content{
    height: 50%;
  }
  .show_invite_wrapper .inviter .user,
  .show_invite_wrapper .invited .user,
  .show_invite_wrapper .right .shop,
  .show_invite_wrapper .right .calender,
  .show_invite_wrapper .left .title {
    height: 100%;
  }
  .show_invite_wrapper .invited {
    display: block;
  }
  .show_invite_wrapper .left .title p{
    text-orientation: upright;
    writing-mode: vertical-rl;
    font-size: 20px;
    text-align:center;
    margin: 20px auto;
  }
  .show_invite_wrapper .left .user {
    height: 100%;
    flex-direction: row;
    justify-content: space-around;
  }
  .show_invite_wrapper .inviter .user {
    border-bottom: 2px solid #eee;
  }
  .show_invite_wrapper .right .action {
    width: 50%;
  }
}
@media (min-width: 0px) and (max-width: 768px) {
  .show_invite_wrapper .content{
    height: 50%;
  }
  .show_invite_wrapper .right,
  .show_invite_wrapper .inviter,
  .show_invite_wrapper .invited {
    height: 100%;
  }
  .show_invite_wrapper .left .title p{
    text-align: center;
    font-size: 38px;
    margin-top: 5px;
  }
  .show_invite_wrapper .inviter {
    border-right: 2px solid #eee;
  }
  .show_invite_wrapper .right .shop {
    height: 600px;
  }
  .show_invite_wrapper .right .action {
    margin-bottom: 60px;
    position: relative;
  }
  .show_invite_wrapper .right .calender {
    height: 800px;
  }
  .show_invite_wrapper .right .el-calendar-day {
    height: 80px;
  }
}
</style>