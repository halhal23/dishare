<template>
  <el-main class="invite_wrapper">
    <el-steps :active="active" class="invite_steps">
      <el-step title="Step 1" :status="eachStatus[0]"></el-step>
      <el-step title="Step 2" :status="eachStatus[1]"></el-step>
      <el-step title="Step 3" :status="eachStatus[2]"></el-step>
      <el-step title="Submit" status="success"></el-step>
    </el-steps>
    <el-row style="width: 100%;">
      <el-col :span="24" :md="14">
        <el-carousel @change="prev" :autoplay="false" :loop="false" indicator-position="none" height="600px">
          <el-carousel-item>
            <h3 class="medium">Who do you want to invite?</h3>
              <el-tabs v-model="activeName" @tab-click="handleClick" style="padding: 15px;">
                <el-tab-pane label="Followers" name="first">
                  <div class="users_container" style="overflow: hidden;">       
                    <el-card v-for="u in users" :key="u.id">
                      <div class="user_card" @click="selectUser(u)">
                        <el-avatar :src="u.image.url" :size="40"></el-avatar>
                        <p style="font-size: 20px; font-weight: bold;margin: 0 30px;">{{ u.name }}</p>
                        <p style="font-size: 12px;">since: {{ u.created_at.substr(0, 10) }}</p>
                      </div>
                    </el-card>
                  </div>
                </el-tab-pane>
                <el-tab-pane label="All users" name="second">
                  <div class="users_container" style="overflow: hidden;">       
                    <el-card v-for="u in all_users" :key="u.id">
                      <div class="user_card" @click="selectUser(u)">
                        <el-avatar :src="u.image.url" :size="40"></el-avatar>
                        <p style="font-size: 20px; font-weight: bold;margin: 0 30px;">{{ u.name }}</p>
                        <p style="font-size: 12px;">since: {{ u.created_at.substr(0, 10) }}</p>
                      </div>
                    </el-card>
                  </div>
                </el-tab-pane>
              </el-tabs>
          </el-carousel-item>
          <el-carousel-item>
            <div class="find_food_wrapper">
              <h3 class="medium">What are we going to eat?</h3>
              <el-tabs v-model="activeName">
                <el-tab-pane label="Find a restaurant" name="first" style="padding: 0 10px;">
                  <el-input placeholder="Please input" v-model="keyword" class="input-with-select">
                    <el-button @click="searchShops" slot="append" icon="el-icon-search"></el-button>
                  </el-input>
                  <div class="many_shops">
                    <el-card v-for="s in shops" :key="s.id">
                      <div style="display: flex;align-items: center; margin-bottom: 10px;">
                        <el-avatar :src="s.image_url.shop_image1" :size="40"></el-avatar>
                        <span style="font-size: 12px;margin-left: 12px;">{{ s.name }}</span>
                      </div>
                      <el-button @click="showShopInfo(s)" type="success" size="small" plain round>Show info</el-button>
                      <el-button @click="selectFood(s)" type="warning" size="small" plain round>take it</el-button>
                    </el-card>
                  </div>
                </el-tab-pane>
                <el-tab-pane label="If the store is undecided" name="second">
                  <el-input v-model="somethingToEat" style="margin: 20px 0;" placeholder="Enter something to eat." prefix-icon="el-icon-fork-spoon"></el-input> 
                  <el-button @click="desideSomethingToEat" type="success" plain round>Decide</el-button>             
                </el-tab-pane>
              </el-tabs>
            </div>
          </el-carousel-item>
          <el-carousel-item>
            <h3 class="medium">When do you want to go?</h3>
            <div class="date_container">
              <div class="block">
                <span class="demonstration">Dates</span>
                <el-date-picker
                  type="date"
                  v-model="formDate"
                  value-format="yyyy/MM/dd"
                  placeholder="Pick date">
                </el-date-picker>
              </div>
            </div>
            <el-button @click="selectDate" type="success" style="margin: 40px auto;display: block;" plain round>Decide</el-button>   
          </el-carousel-item>
          <el-carousel-item>
            <h3 class="medium">Finally! Enter a comment and let's invite you in!</h3>
            <div style="padding: 40px;">
              <el-input v-model="comment" placeholder="Comment" type="textarea" :rows="4"></el-input>
              <el-button @click="submitInvite" type="success" style="margin: 40px auto;display: block;" plain round>Invite the user</el-button>
            </div>
          </el-carousel-item>
        </el-carousel>
      </el-col>
      <el-col :span="24" :md="10">
        <div class="invite_content_card">
          <div style="padding: 5px 20px; background: #eec;">
            <el-checkbox :disabled="!isSelectedUser" v-model="isSelectedUser" @change="deselectUser">
              <span style="font-size: 20px;">
                The user you invite
              </span>
            </el-checkbox>
          </div>
          <div style="padding: 20px;">
            <el-card v-if="isSelectedUser">
              <div class="user_card">
                <el-avatar :src="selectedUser.image.url" :size="40"></el-avatar>
                <p style="font-size: 20px; font-weight: bold;margin: 0 30px;">{{ selectedUser.name }}</p>
                <p style="font-size: 12px;">since: {{ selectedUser.created_at.substr(0, 10) }}</p>
              </div>
            </el-card>
          </div>
        </div>
        <div class="invite_content_card">
          <div style="padding: 5px 20px; background: #eec;">
            <el-checkbox :disabled="!isSelectedFood" v-model="isSelectedFood" @change="deselectFood">
              <span style="font-size: 20px;">
                The food you invite.
              </span>
            </el-checkbox>
          </div>
          <div style="padding: 20px;">
            <el-card v-if="isSelectedFood">
              <div class="user_card" v-if="selectedFood">
                <el-avatar :src="selectedFood.image_url.shop_image1" :size="40"></el-avatar>
                <p style="font-size: 9px; font-weight: bold;margin: 0 30px;">{{ selectedFood.name }}</p>
              </div>
              <div class="user_card" v-else>
                <p style="font-size: 12px; font-weight: bold;margin: 0 30px;">{{ somethingToEat }}</p>
              </div>
            </el-card>
          </div>
        </div>
        <div class="invite_content_card">
          <div style="padding: 5px 20px; background: #eec;">
            <el-checkbox :disabled="!isSelectedDate" v-model="isSelectedDate" @change="deselectDate">
              <span style="font-size: 20px;">
                The date you invite.
              </span>
            </el-checkbox>
          </div>
          <div style="padding: 20px;">
            <el-card v-if="isSelectedDate">
              <div class="user_card">
                <p style="font-size: 12px; font-weight: bold;margin: 0 30px;">You invite in {{ selectedDate }}.</p>
              </div>
            </el-card>
          </div>
        </div>
      </el-col>
    </el-row>
    <shopInfoModal :shopInfoModalVisible="shopInfoModalVisible" @onModal="onModal(false)" />
  </el-main>
</template>
<script>
import shopInfoModal from '~/components/modals/shop-info-modal.vue'
import { mapGetters, mapMutations } from 'vuex'
export default {
  async asyncData({ $axios, store }){
    const baseUrl = process.client ? process.env.browserBaseUrl : process.env.apiBaseUrl
    const data = await $axios.$get(baseUrl + `/api/users/${store.state.auth.currentUser.id}`)
    return {
      users: data.followings,
    }
  },
  data(){
    return {
      active: 0,
      all_users: [],
      isSelectedUser: false,
      isSelectedFood: false,
      isSelectedDate: false,
      selectedUser: {} ,
      selectedFood: {
        name: '',
        url: '',
        image_url: { shop_image1: '' },
        latitude: 0,
        longitude: 0,
        address: '',
      },
      selectedDate: '',
      somethingToEat: '',
      keyword: '',
      activeName: 'first',
      eachStatus: ['process', 'wait', 'wait'],
      shopInfoModalVisible: false,
      formDate: '',
      comment: ''
    }
  },
  computed: {
    ...mapGetters({ 
      shops: 'shops/shops',
    }),
  },
  methods: {
    prev(num){
      this.active = num
      switch (num){
        case 0:
          this.eachStatus[0] = 'process'
          this.eachStatus[1] = 'wait'
          break
        case 1:
          this.eachStatus[0] = this.isSelectedUser ? 'success' : 'error'
          this.eachStatus[1] = 'process'
          this.eachStatus[2] = 'wait'
          break
        case 2:
          this.eachStatus[1] = this.isSelectedFood ? 'success' : 'error'
          this.eachStatus[2] = 'process'
          break
        case 3:
          this.eachStatus[2] = this.isSelectedDate ? 'success' : 'error'
      }
    },
    selectUser(user){
      this.isSelectedUser = true
      this.selectedUser = user
    },
    deselectUser(bool){
      this.selectedUser = null
      this.isSelectedUser = false
    },
    async handleClick(tab) {
      if (tab.label == 'All users'){
        const data = await this.$axios.$get(process.env.browserBaseUrl + `/api/users`)
        this.all_users = data
      }
    },
    searchShops(){
      this.$axios.$get('/api/', {
        params: {
          keyid: process.env.gnavi_api_key,
          name: this.keyword
        }
      }).then( res => {
          this.setShops(res.rest)
          this.$notify({
            type: 'success',
            title: `${res.rest.length}店ヒットしました！`,
            message: 'Search Results',
            position: 'bottom-left',
            duration: 3000
          })
      }).catch( err => { console.log(err) })},
    showShop(shop){
    },
    showShopInfo(shop){
      this.onModal(true)
      this.setShopInfo(shop)
    },
    onModal(bool){
      this.shopInfoModalVisible = bool
    }, 
    selectFood(food){
      this.selectedFood = food
      this.isSelectedFood = true
    },
    deselectFood(bool){
      this.isSelectedFood = false
      this.selectedFood = null
    },
    desideSomethingToEat(){
      this.isSelectedFood = true
    },
    selectDate(){
      if (this.formDate !== ''){
        this.isSelectedDate = true
        this.selectedDate = this.formDate
      }
    },
    deselectDate(bool){
      this.isSelectedDate = false
      this.selectedDate = ''
    },
    submitInvite(){
      this.$axios.$post(process.env.browserBaseUrl + '/api/invitations', {
        inviter_id: this.$store.state.auth.currentUser.id,
        invited_id: this.selectedUser.id,
        shop_name: this.selectedFood.name,
        shop_site_url: this.selectedFood.url,
        shop_image_url: this.selectedFood.image_url.shop_image1,
        shop_latitude: this.selectedFood.latitude,
        shop_longitude: this.selectedFood.longitude,
        shop_address: this.selectedFood.address,
        something_to_eat: this.somethingToEat,
        invite_date: this.selectedDate,
        comment: this.comment
      }).then(res => {
        this.$router.push(`/invitations/${res.id}`)
      }).catch(err => { console.log(err) })
    },
    ...mapMutations({ 
      setShops: 'shops/setShops',
      setShopInfo: 'shops/setShopInfo'
    })
  },
  components: {
    shopInfoModal
  },
}
</script>
<style>
.invite_wrapper {
  min-height: 100vh;
  background: rgba(255, 227, 184, 0.6);
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  padding: 70px 0;
}
.invite_wrapper  .el-carousel__container {
  width: 500px;
  margin: 0 auto;
}
.invite_wrapper  .el-carousel__item h3 {
  color: #475669;
  text-align: center;
  font-size: 20px;
  opacity: 0.75;
  margin: 10px 0;
}
.invite_wrapper .users_container .el-card {
  width: 80%;
  margin: 20px auto;
  width: 280px;
}
.invite_wrapper .users_container .el-card:hover {
  box-shadow: 0 0 18px #aaa;
}
.invite_wrapper .el-card__body {
  height: 100%;
  padding: 5px;
}
.invite_wrapper  .el-card__body .user_card {
  display: flex;
  justify-content: space-around;
  align-items: center;
  height: 100%;
}

.invite_wrapper  .el-carousel__item {
  background: #fff;
  border: 1px solid #ccc;
}
.invite_steps {
  width: 300px;
  margin-bottom: 50px;
}
.invite_content_card {
  width: 400px;
  height: 120px;
  box-shadow: 0 0 12px #ccc;
  margin-bottom: 20px;
  background: #fff;
}
.find_food_wrapper {
  margin: 10px;
}
.many_shops {
  width: 100%;
  height: 100%;
  background: #fff;
}
.many_shops .el-card {
  margin: 10px 12px;
  padding: 10px;
}
.date_container {
  display: flex;
}
.date_container .block {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-around;
  width: 100%;
  height: 100px;
}
@media (min-width: 0px) and (max-width: 992px) {
  .invite_wrapper  .el-carousel__container {
    width: 90%;
  }
  .invite_content_card {
    margin: 20px auto;
  }
  .invite_steps {
    margin-bottom: 10px;
  }
}
</style>