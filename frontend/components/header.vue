<template>
  <el-header>
    <el-menu :default-active="activeIndex" :class="{header_menu: true,hidden: isHidden}" mode="horizontal" @select="handleSelect">
      <el-menu-item class="header_item_md logo">
        <img src="~/static/images/text-logo.png" height="50px" width="160px" style="background: transparent;padding:0 20px;border-radius: 20px;">
      </el-menu-item>
      <el-menu-item index="1" style="margin-left: auto;" class="header_item_md" @click="toggleHidden">
        <nuxt-link to="/" >HOME</nuxt-link>
      </el-menu-item>
      <el-menu-item index="2" class="header_item_md" @click="toggleHidden">
        <nuxt-link to="/" >ABOUT</nuxt-link>
      </el-menu-item>
      <el-menu-item index="4" class="header_item_md" @click="toggleHidden">
        <a href="#" @click="onModal(true, true)" v-if="!isLoggedIn">LOGIN</a>
        <nuxt-link :to="{ path: `/users/mypage` }" v-else>
          <el-avatar :src="currentUser.image.url" :size="40"></el-avatar>
        </nuxt-link>
      </el-menu-item>
      <el-menu-item index="5" class="header_item_md" @click="toggleHidden">
        <!-- <nuxt-link to="/sign_in_up" v-if="!isLoggedIn">SIGNUP</nuxt-link> -->
        <a href="#" @click="onModal(true, false)" v-if="!isLoggedIn">SIGNUP</a>
        <span @click="clickLogout" class="item_span" v-else>LOGOUT</span>
      </el-menu-item>
    </el-menu>

    <!-- 画面サイズ700px以下のデフォルトのヘッダーレイアウト -->
    <el-menu class="header_menu_respon" mode="horizontal">
      <el-menu-item >
        <img src="~/static/images/text-logo.png" height="50px" width="130px">
      </el-menu-item>
      <el-menu-item style="margin-left: auto;" @click="toggleHidden" >
        <i class="el-icon-s-operation" style="font-size: 30px; margin: 0 20px;"></i>
      </el-menu-item>
    </el-menu>
    <authFormModal :testModal="testModal" :isLogin="isLogin" @onModal="onModal(false)" />
  </el-header>
</template>

<script>
import authFormModal from '~/components/auth-form-modal.vue'
import { mapGetters, mapActions } from 'vuex'
export default {
  data() {
    return {
      activeIndex: '',
      activeIndex2: '1',
      isHidden: true,
      testModal: false,
      isLogin: false
    };
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/currentUser',
      isLoggedIn: 'auth/isLoggedIn',
    })
  },
  methods: {
    handleSelect(key, keyPath) {
      console.log(key, keyPath);
    },
    toggleHidden(){
      this.isHidden = !this.isHidden
    },
    onModal(testModal, isLogin){
      this.testModal = testModal
      this.isLogin = isLogin
    },
    clickLogout(){
      this.$confirm('Are you sure you want to logout?', 'LOGOUT', {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
        type: 'warning',
        center: true
      }).then(() => { 
        this.logout() 
        this.$notify({
          title: 'Logout successfully',
          message: 'Thank you for visiting!',
          type: 'success'
        });
      }).catch(() => {})
    },
    ...mapActions({
      logout: 'auth/logout'
    })
  },
  components: {
    authFormModal
  }
}
</script>

<style>
.el-header {
  background: transparent;
  position: fixed;
  z-index: 5;
  top: 0;
  width: 100%;
}

.header_menu {
  display: flex;
  background: transparent;
  flex-wrap: wrap;
  border-bottom: none !important;
}
.header_menu {
  display: flex;
  background: transparent;
  flex-wrap: wrap;
  border-bottom: none !important;
}

.header_menu_respon{
  display: none;
}

.item_span {
  padding: 0 20px;
  display: block;
  color: #888 !important;
}


.el-menu--horizontal > .el-menu-item:not(.is-disabled):focus,
.el-menu--horizontal > .el-menu-item:not(.is-disabled):hover {
  background: rgb(151, 96, 24, .5);
}

@media (min-width: 0px) and (max-width: 768px) {
  .el-header {
    padding: 0;
    position: fixed;
  }
  
  .header_menu {
    position: absolute;
    width: 100%;
    top: 60px;
    left: 0;
    transition: .5s;
    background: rgb(226, 211, 188);
  }
  .header_menu.hidden {
    left: -100%;
  }
  .header_menu_respon{
    display: flex;
    background: transparent;
    border-bottom: none !important;
  }
  .header_item_md {
    width: 100%;
    flex-shrink: 0;
    border-bottom: 1px solid #999 !important;
  }
  .header_item_md.logo {
    display: none;
  }
  .item_span {
    width: 100%;
  }
}
</style>