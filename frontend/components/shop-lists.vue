<template>
  <div class="list-container">
    <div class="searched-list"> 
      <!-- <shopLists v-for="shop in shops" :key="shop.name" class="shop-card" :shopInfo="shop"/> -->
      <div v-for="shop in shops" :key="shop.name" class="shop-card">{{ shop.name }}</div>
    </div>
    
  </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
export default {
  computed: {
    ...mapGetters({ shops: 'shops/shops'})
  }
}
</script>

<style scoped>
.list-container {
  width: 100%;
}
div.searched-list {
  width: 100%;
  /* border: 1px solid gray;
  width : 400px;
  height: 150px;
  margin: 10px 0;
  flex-shrink: 0; */
}
.searched-list {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  background: #eee;
}

.shop-card {
  flex-shrink: 0;
  width: 400px;
  height: 100px;
  border: 1px solid gray;
  margin: 10px 0;
}
</style>