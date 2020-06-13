<template>
  <el-row class="searchInput" style="background: rgba(255,255,255,0);">
    <el-col :span="24" :lg="12">
      <el-input placeholder="検索キーワード" v-model="keyword"></el-input>
    </el-col>
    <el-col :span="16" :lg="8">
      <el-select v-model="select" placeholder="指定せず検索" class="select" style="width: 100%;background: #F5F7FA;">
        <el-option label="近くの店を探す" value="1"></el-option>
        <el-option label="人気店を探す" value="2"></el-option>
        <el-option label="指定せず検索" value="3"></el-option>
        <el-option label="検索結果をクリア" value="4"></el-option>
      </el-select>
    </el-col>
    <el-col :span="8" :lg="4">
      <el-button @click="do_either_search" icon="el-icon-search" style="width: 100%;" class="search-icon"></el-button>
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
    getFirst(){
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
    do_either_search(){
      switch (this.select) {
        case '1':
          console.log(1)
          this.getShops()
          break
        case '2':
          console.log(2)
          this.getFirst()
          break
        case '3':
        case '':
          console.log(3)
          this.getFirst()
          break
        case '4':
          this.clearShops()
      }
    },
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
      
      this.$msgbox({
        title: 'ご検索ありがとうございます!',
        message: 'ログインしていただければ、より詳細な検索と友人との共有が可能です！',
        confirmButtonText: 'OK'
      })
    },
    success(position){
      this.setCurrentPosition({ position: { lat: position.coords.latitude, lng: position.coords.longitude }})
      this.$axios.$get('/api/', {
        params: {
          keyid: process.env.gnavi_api_key,
          name: this.keyword,
          latitude: this.currentPosition.position.lat,
          longitude: this.currentPosition.position.lng,
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
}
</style>