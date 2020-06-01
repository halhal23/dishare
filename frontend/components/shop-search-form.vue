<template>
  <el-row class="searchInput" style="background: rgba(255,255,255,0);">
    <el-col :span="24" :lg="12">
      <el-input placeholder="検索キーワード" v-model="keyword"></el-input>
    </el-col>
    <el-col :span="16" :lg="8">
      <el-select v-model="select" placeholder="指定せず検索" class="select" style="width: 100%;background: #F5F7FA;">
        <el-option label="近くの店を探す" value="1"></el-option>
        <el-option label="人気店を探す" value="2"></el-option>
        <el-option label="指定せず検索" value="3"></el-option>
      </el-select>
    </el-col>
    <el-col :span="8" :lg="4">
      <el-button @click="do_either_search" icon="el-icon-search" style="width: 100%;"></el-button>
    </el-col>
  </el-row>
</template>

<script>
export default {
  data(){
    return {
      keyword: '',
      select: ''
    }
  },
  methods: {
    do_either_search(){
      switch (this.select) {
        case '1':
          console.log(1111)
          break
        case '2':
          console.log(222222)
          break
        case '3', '':
          console.log(333333)
          break
        default:
          console.log('defaul');
          break
      }
    }
  },
}
</script>
