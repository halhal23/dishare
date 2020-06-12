<template>
  <el-main>
    <el-divider class="title" style="margin: 60px;">
      <h1 @click="test">You can do a detailed search</h1>
    </el-divider>
    
    <el-form label-width="120px">

      <el-form-item label="keyword">
        <el-input v-model="params.keyword"></el-input>
      </el-form-item>

      <el-form-item label="Category">
        <el-select v-model="params.category" placeholder="Category">
          <el-option value="肉"></el-option>
          <el-option value="魚"></el-option>
          <el-option value="ラーメン"></el-option>
          <el-option value="カフェ"></el-option>
          <el-option value="スイーツ"></el-option>
          <el-option value="韓国料理"></el-option>
          <el-option value="">指定なし</el-option>
        </el-select>
      </el-form-item>

      <el-form-item label="Current location">
        <el-switch v-model="params.current_positon"></el-switch>
      </el-form-item>

      <el-form-item label="Options">
          <el-checkbox label="No smoking" v-model="params.options.smoking" border></el-checkbox>
          <el-checkbox label="Lunch" v-model="params.options.lunch" border></el-checkbox>
          <el-checkbox label="Cards" v-model="params.options.cards" border></el-checkbox>
          <el-checkbox label="bottomless cup(食べ放題)" v-model="params.options.bottomless_cup" border></el-checkbox>
          <el-checkbox label="Delivery" v-model="params.options.delivery" border></el-checkbox>
          <el-checkbox label="wifi" v-model="params.options.wifi" border></el-checkbox>
      </el-form-item>

      <div style="width: 300px; margin: 30px auto;">
        <!-- <shopSearchBtn /> -->
        <el-button @click="getShops" icon="el-icon-search" style="width: 100%;" class="search-icon"></el-button>
      </div>

    </el-form>
    <shopLists />
  </el-main>
</template>

<script>
import shopLists from '~/components/shop-lists.vue'
import shopSearchBtn from '~/components/shop-search-btn.vue'
import { mapGetters, mapMutations } from 'vuex'
export default {
  data(){
    return {
      width: "150px",
      params: {
        keyword: '',
        current_positon: false,
        category: '',
        options: {
          smoking: false,
          lunch: false,
          cards: false,
          delivery: false,
          bottomless_cup: false,
          wifi: false,
        },
      }
    }
  },
  methods: {
    test(){
      console.log('test')
      console.log(this.params)
    },

    // ぐるなびapiでレストラン検索
    getShops(){
      this.$axios.$get('/api/', {
        params: {
          keyid: process.env.gnavi_api_key,
          name: this.params.keyword,
          no_smoking: this.params.options.smoking ? 1 : 0,
          lunch: this.params.options.lunch ? 1 : 0,
          card: this.params.options.cards ? 1 : 0,
          bottomless_cup: this.params.options.bottomless_cup ? 1 : 0,
          deliverly: this.params.options.delivery ? 1 : 0,
          wifi: this.params.options.wifi ? 1 : 0,
        }
      }).then( res => {
        this.setShops(res.rest)
        this.$notify({
          type: 'success',
          title: `${res.rest.length}店ヒットしました！`,
          message: `ラーメンの検索結果`,
          position: 'bottom-left',
          duration: 3000
        })
        console.log('searched !!')
        console.log(res)
      }).catch( err => {
        console.log(err)
      })
    },

    // storeにレストラン情報をセット
    ...mapMutations({ 
      setShops: 'shops/setShops',
      setCurrentPosition: 'shops/setCurrentPosition',
    })
  },
  components: {
    shopLists,shopSearchBtn
  }
}
</script>

<style>
.el-checkbox {
  margin-left: 0 !important;
}
.el-divider--horizontal.title {
  margin: 60px 0;
}
</style>