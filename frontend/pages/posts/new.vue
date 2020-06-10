<template>
  <el-main>
    <h2>posts new </h2>
    <h2>posts new </h2>
    <h2>posts new </h2>
    <h2>posts new </h2>
    <shopSearchForm />
    <shopLists />
  </el-main>
</template>

<script>
import shopLists from '~/components/shop-lists.vue'
import shopSearchForm from '~/components/shop-search-form.vue'
export default {
  components: {
    shopLists,shopSearchForm
  }
}
</script>