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
            <el-timeline-item :timestamp="sliceCreatedAt(invitation.created_at)" placement="top">
              <el-card>
                <h4 style="margin: 5px 0;">{{ invitation.comment }}</h4>
                <div class="flex-center" style="justify-content: flex-start;">
                  <el-avatar :src="inviter.image.url" :size="30"></el-avatar>
                  <p style="margin-left: 30px;">{{ inviter.name }}</p>
                </div>
              </el-card>
            </el-timeline-item>
            <el-timeline-item v-for="c in conversations" :key="c.id" :timestamp="sliceCreatedAt(c.created_at)" placement="top">
              <el-card>
                <h4 style="margin: 5px 0;">{{ c.message }}</h4>
                <div class="flex-center" style="justify-content: flex-start;">
                  <el-avatar v-if="c.user_id == inviter.id" :src="inviter.image.url" :size="30"></el-avatar>
                  <el-avatar v-else :src="invited.image.url" :size="30"></el-avatar>
                  <p v-if="c.user_id == inviter.id" style="margin-left: 30px;">{{ inviter.name }}</p>
                  <p v-else style="margin-left: 30px;">{{ invited.name }}</p>
                </div>
              </el-card>
            </el-timeline-item>
          </el-timeline>
          <div class="comment_form">
            <el-input v-model="message" type="textarea" style="margin-bottom: 30px;" :rows="4"></el-input>
            <el-button @click="createComment">Comment</el-button>
          </div>
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
            <el-tabs v-model="activeName" v-if="invitation.shop_name">
              <el-tab-pane style="color: #eee" label="Shop MAP" name="first">
                <GmapMap
                  :center="{ lat: Number(invitation.shop_latitude), lng: Number(invitation.shop_longitude) }"
                  :zoom="15"
                  map-type-id="terrain"
                  style="width: 100%; height: 450px;"
                >
                  <GmapMarker
                    :position="{ lat: Number(invitation.shop_latitude), lng: Number(invitation.shop_longitude) }"
                    :clickable="true"
                    :draggable="true"
                  />
                </GmapMap>
              </el-tab-pane>
              <el-tab-pane  style="color: #eee;text-align: center" label="Shop INFO" name="second">
                <el-avatar :src="invitation.shop_image_url" :size="150"></el-avatar>
                <p style="margin-bottom: 20px;">{{ invitation.shop_name }}</p>
                <p style="margin-bottom: 20px;">{{ invitation.shop_address }}</p>
                <a :href="invitation.shop_site_url" style="color: #fff;font-weight: bold;" target="__blank">詳しくはこちら</a>
              </el-tab-pane>
            </el-tabs>
            <h3 v-else class="flex-center" style="color: #eee;height: 100%;">
              We're going to have {{ invitation.something_to_eat }}.
            </h3>

            <div class="action flex-center" :class="{ng: result == 2, ok: result == 1}" @change="changeResult">
              <el-radio-group v-model="result" v-if="invited.id == $store.state.auth.currentUser.id">
                <el-radio :label="1">OK ! Let's go eat.</el-radio>
                <el-radio :label="2">I'm sorry. I can't go.</el-radio>
                <el-radio :label="3">please waiting.</el-radio>
              </el-radio-group>
              <el-radio-group v-model="result" v-else>
                <el-radio :disabled="true" :label="1">OK ! Let's go eat.</el-radio>
                <el-radio :disabled="true" :label="2">I'm sorry. I can't go.</el-radio>
                <el-radio :disabled="true" :label="3">please waiting.</el-radio>
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
    return {
      invitation: data,
      inviter: data.inviter,
      invited: data.invited,
      dateValue: data.invite_date,
      conversations: data.invite_conversations,
      result: data.result
    }
  },
  data(){
    return {
      activeName: 'first',
      radio1: '',
      message: '',
    }
  },
  methods: {
    createComment(){
      this.$axios.$post(process.env.browserBaseUrl + '/api/invite_conversations', {
          message: this.message,
          user_id: this.$store.state.auth.currentUser.id,
          invitation_id: this.invitation.id
        }).then(res => {
        this.conversations = res
        this.message = ''
      }).catch(err => { console.log(err) })
    },
    // コメントの日付のフォーマットを整形。
    sliceCreatedAt(str){
      return str.substr(0, 10) + "  " + str.substr(11, 8)
    },
    changeResult(result){
      this.$axios.$put(process.env.browserBaseUrl + `/api/invitations/${this.invitation.id}`, {
          result: this.result
        }).then(res => {
        this.invitation = res
        this.message = ''
      }).catch(err => { console.log(err) })
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
  padding: 0 30px;
}
.show_invite_wrapper .right .ok{
  background: rgb(183, 255, 89);
}
.show_invite_wrapper .right .ng{
  background: rgb(255, 137, 133);
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
  padding: 70px 20px 10px;
  position: relative;
}
.show_invite_wrapper .center .el-timeline {
  padding: 0;
  scroll-snap-type: y;
  scroll-snap-align: start;
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