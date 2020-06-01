<template>
  <el-header>
    <el-menu :default-active="activeIndex" :class="{header_menu: true,hidden: isHidden}" mode="horizontal" @select="handleSelect">
      <el-menu-item class="header_item_md logo">
        <img src="images/text-logo.png" height="50px" width="130px" style="background: #fff;">
      </el-menu-item>
      <el-menu-item index="1" style="margin-left: auto;" class="header_item_md" @click="toggleHidden">
        <nuxt-link to="/top" >HOME</nuxt-link>
      </el-menu-item>
      <el-menu-item index="2" class="header_item_md" @click="toggleHidden">ABOUT</el-menu-item>
      <el-menu-item index="4" class="header_item_md" @click="toggleHidden">LOGIN</el-menu-item>
      <el-menu-item index="5" class="header_item_md" @click="toggleHidden">SIGNUP</el-menu-item>
    </el-menu>

    <!-- 画面サイズ700px以下のデフォルトのヘッダーレイアウト -->
    <el-menu class="header_menu_respon" mode="horizontal">
      <el-menu-item >
        <img src="images/text-logo.png" height="50px" width="130px">
      </el-menu-item>
      <el-menu-item style="margin-left: auto;" @click="toggleHidden" >
        <i class="el-icon-s-operation" style="font-size: 30px;"></i>
      </el-menu-item>
    </el-menu>
  </el-header>
</template>

<script>
  export default {
    data() {
      return {
        activeIndex: '',
        activeIndex2: '1',
        isHidden: true
      };
    },
    methods: {
      handleSelect(key, keyPath) {
        console.log(key, keyPath);
      },
      toggleHidden(){
        this.isHidden = !this.isHidden
      }
    }
  }
</script>

<style>
.el-header {
  background: transparent;
  position: fixed;
  z-index: 10;
  top: 0;
  width: 100%;
}

.header_menu {
  display: flex;
  background: transparent;
  flex-wrap: wrap;
}

.header_menu_respon{
  display: none;
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
    background: rgb(229, 226, 221);
  }
  .header_menu.hidden {
    left: -100%;
  }
  .header_menu_respon{
    display: flex;
  }
  .header_item_md {
    width: 100%;
    flex-shrink: 0;
  }
  .header_item_md.logo {
    display: none;
  }
}
</style>