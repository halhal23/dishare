<template>
  <div>
    <div class="main-container">
      <img src="images/dishare-main-logo.png" width="400px" height="300px">
      <h2>
        Dishareへようこそ <br>
        「美味しい」を共有しましょう
      </h2>
      <p>早速、キーワードを検索して、「美味しい」を検索してみましょう</p>
      <el-input placeholder="Please input" v-model="keyword" class="input-with-select" style="width:600px;">
        <el-select v-model="select" slot="prepend" placeholder="近くの店を探す" style="width:200px;">
          <el-option label="近くの店を探す" value="1"></el-option>
          <el-option label="人気店を探す" value="2"></el-option>
        </el-select>
        <el-button @click="getShops" slot="append" icon="el-icon-search"></el-button>
      </el-input>
    </div>
    <shopLists /> <!-- 検索結果一覧を表示するコンポーネント -->
  </div>
</template>

<script>
import shopLists from '~/components/shop-lists.vue'
import { mapGetters, mapMutations } from 'vuex'
export default {
  components: {
    shopLists
  },
  data(){
    return {
      keyword: '',
      select: '',
      dialogShopDetailVisible: false,
      detailName: 'no name',
      currentLat: 0,
      currentLng: 0
    }
  },
  computed: {
    ...mapGetters({
      shops: 'shops/shops',
      currentPosition: 'shops/currentPosition'
      })
  },
  methods: {
    getShops(){
      console.log(this)
      if (!navigator.geolocation) {
        alert('Geolocation not supported');
        return;
      }
      navigator.geolocation.getCurrentPosition(this.success, function() {
        alert('Geolocation failed!');
        return;
      });
      this.$alert('ログインして頂くと、より詳細な検索が可能です！', '検索ありがとうございます！', {
        confirmButtonText: 'OK',
      });
    },
    showShopDetail(name){
      this.dialogShopDetailVisible = true
      this.detailName = name
      console.log('alert ' + name)
    },
    success(position){
      // this.geoPosition.lat = position.coords.latitude;
      // this.geoPosition.lng = position.coords.longitude;
      this.currentLat = position.coords.latitude
      this.currentLng = position.coords.longitude
      this.setCurrentPosition({ lat: position.coords.latitude, lng: position.coords.longitude})
      this.$axios.$get('/api/', {
        params: {
          keyid: process.env.gnavi_api_key,
          name: this.keyword,
          latitude: this.currentPosition.lat,
          longitude: this.currentPosition.lng,
          range: 5
        }
      }).then( res => {
        console.log('成功です。')
        console.log(this)
        console.log(res)
        this.setShops(res.rest)
        this.$notify({
          type: 'success',
          title: `${res.rest.length}店ヒットしました！`,
          message: `${this.keyword}の検索結果`,
          position: 'bottom-left',
          duration: 2000
        })
      }).catch( err => {
        console.log('失敗です。')
        console.log(err)
      })
      console.log('success!! geolocation');
    },
    ...mapMutations({ 
      setShops: 'shops/setShops',
      setCurrentPosition: 'shops/setCurrentPosition',
      })
  },
  mounted(){
    console.log('↓mouted')
    console.log(this)
  }
}
</script>

<style>
/* .container: 1; */
/* .container:before: -1; */
/* header: 2; */

.main-container {
  position: relative;
  z-index: 1;
  margin: 0 auto;
  min-height: 100vh;
  display: flex;
  padding: 100px 0;
  justify-content: flex-start;
  flex-direction: column;
  align-items: center;
  text-align: center;
  background-image: url(~@/static/images/top-bg-main.jpg);
  background-size: cover;
  background-position: center; 
}

.main-container:before {
  content: '';
  position: absolute;
  z-index: -1;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(255,255,255,0.7);
}

.main-container h2, h3, p {
  margin: 30px 0;
}



</style>
