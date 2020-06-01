<template>
  <el-header>
    <el-menu :default-active="activeIndex" :class="{header_menu: true,hidden: isHidden}" mode="horizontal" @select="handleSelect">
      <el-menu-item class="header_item_md logo">
        <img src="images/text-logo.png" height="50px" width="130px">
      </el-menu-item>
      <el-menu-item index="1" class="header_item_md" @click="toggleHidden">
        <nuxt-route to="/top">ホーム</nuxt-route>
      </el-menu-item>
      <el-menu-item index="2" class="header_item_md" @click="toggleHidden">このサイトについて</el-menu-item>
      <el-menu-item index="4" class="header_item_md" @click="toggleHidden">ログイン</el-menu-item>
      <el-menu-item index="5" class="header_item_md" @click="toggleHidden">新規登録</el-menu-item>
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
        activeIndex: '2',
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
  background: #fff;
  position: fixed;
  z-index: 10;
  top: 0;
  width: 100%;
}

.header_menu {
  display: flex;

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