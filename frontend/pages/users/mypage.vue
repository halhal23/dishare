<template> 
  <el-main class="mypage_wrapper" v-if="currentUser">
    <userInfoCard :user="currentUser" />
  </el-main>
</template>

<script>
import userInfoCard from '~/components/user-info-card.vue'
import { mapGetters } from 'vuex'
export default {
  computed: {
    ...mapGetters({
      currentUser: 'auth/currentUser'
    })
  },
  components: {
    userInfoCard
  }
}
</script>

<style>
.mypage_wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  padding: 0 10px;
}
.text {
  font-size: 14px;
}

.item {
  margin-bottom: 18px;
  text-align: center;
  width: 100%;
  padding: 20px 0;
}

.box-card {
  width: 480px;
}
</style>