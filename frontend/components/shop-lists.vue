<template>
  <el-main class="list-container" v-if="shops">
    <div class="searched-list" > 
      <!-- <shopLists v-for="shop in shops" :key="shop.name" class="shop-card" :shopInfo="shop"/> -->
      <el-card v-for="shop in shops" :key="shop.name" class="shop-card">
        <img :src="shop.image_url.shop_image1" class="shop_image" v-if="shop.image_url.shop_image1"> 
        <img :src="shop.image_url.shop_image1" class="shop_image" v-else-if="shop.image_url.shop_image2"> 
        <img class="shop_image" src="https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png" v-else> 
        <div class="card_shop_info">
          <p class="name">{{ shop.name }}</p>
          <el-tag type="warning" size="mini">{{ shop.category }}</el-tag>
          <p class="opentime" v-if="shop.access">{{ shop.access.station }}から{{ shop.access.walk }}分</p>
          <p class="opentime" v-else>交通アクセス: 記載なし</p>
          <p class="opentime" v-if="shop.opentime">営業時間: {{ shop.opentime }}</p>
          <p class="opentime" v-else>営業時間: 記載なし</p>
          <el-button @click="showShopInfo(shop)" type="success" size="small" plain round>詳細を見る</el-button>
        </div>
      </el-card>
    </div>

    <shopInfoModal :shopInfoModalVisible="shopInfoModalVisible" @onModal="onModal(false)" />
    
  </el-main>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
import shopInfoModal from '~/components/modals/shop-info-modal.vue'
export default {
  components: {
    shopInfoModal
  },
  data(){
    return {
      testModal: false,
      currentDate: new Date(),
      shopInfoModalVisible: false
    }
  },
  computed: {
    ...mapGetters({ shops: 'shops/shops' }),
  },
  methods: {
    showShopInfo(shop){
      this.onModal(true)
      this.setShopInfo(shop)
    },
    onModal(bool){
      this.shopInfoModalVisible = bool
    },
    ...mapMutations({ setShopInfo: 'shops/setShopInfo'})
  },
  mounted(){
    console.log(this.shops)
  }
}
</script>

<style>
.list-container {
  width: 100%;
  /* background: rgb(88, 55, 5); */
  background: linear-gradient(to right,#ffa90a,#ffe9c1);
  /* background-image: url(~@/static/images/dishare-main-logo.png);
  background-size: 70%;
  background-repeat: no-repeat;
  background-position: center; */
  padding-top: 60px;
}
.searched-list {
  width: 100%;
}
.searched-list {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
}

.shop-card {
  flex-shrink: 0;
  width: 500px;
  height: 200px;
  margin: 10px 0;
  padding: 0;
}
.searched-list .el-card__body {
  padding: 0;
  height: 100%;
  display: flex;
}
.shop-card .shop_image{
  width: 200px;
  height: 100%;
}

.card_shop_info {
  overflow: hidden;
  white-space: nowrap;
  padding: 10px 10px 10px 20px;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  justify-content: space-between;
}
.card_shop_info p {
  width: 100%;
  overflow: hidden;
  text-overflow: ellipsis;
}
.card_shop_info p.opentime {
  font-size: 14px;
  color: #999;
}
.card_shop_info p.name {
  font-weight: bold;
  line-height: 30px;
}

@media (min-width: 0px) and (max-width: 600px) {
  .shop-card {
    width: 100%;
    height: 450px;
  }
  .el-card__body {
    flex-direction: column;
  }
  .shop-card .shop_image {
    width: 100%;
    height: 300px;
  }
}
</style>