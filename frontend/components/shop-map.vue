<template>
<div v-if="shop">
  <GmapMap
    :center="shop_position"
    :zoom="15"
    map-type-id="terrain"
    style="width: 500px; height: 500px;"
  >
    <GmapMarker
      :key="index"
      v-for="(m, index) in markers"
      :position="m"
      :clickable="true"
      :draggable="true"
      @click="center=m.position"
    />
  </GmapMap>
</div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
const tokyo = {lat: 35.681167, lng: 139.767052}
export default {
  computed: {
    markers(){
      return [
        tokyo,
        this.shop_position
      ]
    },
    shop_position(){
      return { lat: Number(this.shop.latitude) , lng: Number(this.shop.longitude) }
    },
    ...mapGetters({ shop: 'shops/shop' })
  }
};
</script>