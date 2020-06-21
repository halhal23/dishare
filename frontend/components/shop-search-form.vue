<template>
  <el-row class="searchInput" style="background: rgba(255,255,255,0);">
    <el-col :span="24" :lg="12">
      <el-input placeholder="検索キーワード" v-model="keyword"></el-input>
    </el-col>
    <el-col :span="16" :lg="8">
      <el-select v-model="select" placeholder="指定せず検索" class="select" style="width: 100%;background: #F5F7FA;">
        <el-option label="近くの店を探す" value="1"></el-option>
        <el-option label="指定せず検索" value="2"></el-option>
        <el-option label="検索結果をクリア" value="3"></el-option>
      </el-select>
    </el-col>
    <el-col :span="8" :lg="4">
      <el-button @click="doEitherSearch" icon="el-icon-search" style="width: 100%;" class="search-icon"></el-button>
    </el-col>
  </el-row>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
export default {
  data(){
    return {
      keyword: '',
      select: ''
    }
  },
  computed: {
    ...mapGetters({
      shops: 'shops/shops',
      currentPosition: 'shops/currentPosition'
    })
  },
  methods: {
    // セレクトボックスの値によって、検索の仕方を条件分岐する。
    doEitherSearch(){
      switch (this.select) {
        case '1':
          this.findNearShop()
          this.showPromptForLogin();
          break
        case '2':
        case '':
          this.findShopNoDetail()
          this.showPromptForLogin();
          break
        case '3':
          this.clearShops()
          this.$store.commit('auth/setCurrentUser', null)
          this.$store.commit('auth/setIsLoggedIn', false)
      }
    },
    // 詳細条件なしの検索。
    findShopNoDetail(){
      this.$axios.$get('/api/', {
        params: {
          keyid: process.env.gnavi_api_key,
          name: this.keyword,
        }
      }).then( res => {
        this.setShops(res.rest)
        this.$notify({
          type: 'success',
          title: `${res.rest.length}店ヒットしました！`,
          message: `${this.keyword}の検索結果`,
          position: 'bottom-left',
          duration: 3000
        })
      }).catch( err => {
        console.log(err)
      })
    },
    // 現在位置から近くのお店を探す。
    findNearShop(){
      if (!navigator.geolocation) {
        alert('Geolocation not supported');
        return;
      }

      navigator.geolocation.getCurrentPosition(this.success, function() {
        alert('Geolocation failed!');
        return;
      });
    },
    // 現在位置を正常に取得できた際に走るメソッド。
    success(position){
      this.setCurrentPosition({ position: { lat: position.coords.latitude, lng: position.coords.longitude }})
      this.$axios.$get('/api/', {
        params: {
          keyid: process.env.gnavi_api_key,
          name: this.keyword,
          latitude: position.coords.latitude,
          longitude: position.coords.longitude,
          range: 5
        }
      }).then( res => {
        this.setShops(res.rest)
        
        this.$notify({
          type: 'success',
          title: `${res.rest.length}店ヒットしました！`,
          message: `${this.keyword}の検索結果`,
          position: 'bottom-left',
          duration: 2000
        })
      }).catch( err => {
        console.log(err)
      })
      console.log('success!! geolocation');
    },
    clearShops(){
      console.log('clear')
      this.setShops(null)
    },
    // 検索後にログインを促す。(未ログインの場合のみ)
    showPromptForLogin(){
      if (this.$store.state.auth.currentUser == null){
        this.$msgbox({
          title: 'Thank you for your search!!',
          message: 'Once you log in, you can search for more details and share them with your friends!',
          confirmButtonText: 'OK'
        }).then(()=>{}).catch(()=>{})
      }
    },
    ...mapMutations({ 
      setShops: 'shops/setShops',
      setCurrentPosition: 'shops/setCurrentPosition',
    })
  },
}
</script>

<style>
.el-row.searchInput {
  width: 600px;
}

button.el-button.search-icon,
.select .el-input__inner {
  background: #F5F7FA;
}
@media (min-width: 769px) and (max-width: 1200px) {
  .el-row.searchInput {
    width: 100%;
  }
}
@media (min-width: 0px) and (max-width: 768px) {
  .el-row.searchInput {
    width: 100%;
  }
  .el-message-box {
    width: 90%;
  }
}
</style>