<template>
<div v-if="shop">
  <GmapMap
    :center="shop_position.position"
    :zoom="15"
    map-type-id="terrain"
    style="width: 500px; height: 500px;"
  >
    <GmapMarker
      :key="index"
      v-for="(m, index) in markers"
      :position="m.position"
      :clickable="true"
      :draggable="true"
      :icon="m.icon"
    />
  </GmapMap>
</div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
const tokyo = { position: { lat: 35.681167, lng: 139.767052 } }
export default {
  computed: {
    markers(){
      return [
        tokyo,
        this.shop_position,
        this.currentPosition
      ]
    },
    shop_position(){
      return { 
        position: { lat: Number(this.shop.latitude) , lng: Number(this.shop.longitude) },
        icon: { 
          url: 'https://maps.google.com/mapfiles/ms/icons/green-dot.png'
        }
      }
    },
    ...mapGetters({ 
      shop: 'shops/shop',
      currentPosition: 'shops/currentPosition',
    })
  }
};
</script>