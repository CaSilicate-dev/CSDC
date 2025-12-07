<script setup>
import { onMounted, ref } from 'vue'
import dayjs, { Dayjs } from 'dayjs'
import { message } from 'ant-design-vue'

const [messageApi, contextHolder] = message.useMessage();

const dopen = ref(false)
const unit = ref("m")
const targetTime = ref(dayjs("15:50:00", "HH:mm:ss"))
const prec = ref(1)
const title1 = ref("距离下课还有")
const title2 = ref("分钟")
const t1fsize = ref(48)
const vfsize = ref(96)
const t2fsize = ref(48)
const value = ref(0.0)

const heightOffset = ref(-96)

function showDrawer() {
  dopen.value = true
}
function resetValue() {
  unit.value = "m"
  targetTime.value = dayjs("15:50:00", "HH:mm:ss")
  prec.value = 1
  title1.value = "距离下课还有"
  title2.value = "分钟"
  t1fsize.value = 48
  vfsize.value = 96
  t2fsize.value = 48
  heightOffset.value = -96
  messageApi.success('已重置为默认值');
}

function roundToDecimal(number, decimalPlaces) {
  const factor = 10 ** decimalPlaces;
  return Math.round(number * factor) / factor;
}

function updateTime() {
  const now = dayjs()
  const target = targetTime.value
  let diff = target.diff(now, 'milliseconds')
  if (unit.value === "h") {
    diff = diff / (1000 * 60 * 60)
  } else if (unit.value === "m") {
    diff = diff / (1000 * 60)
  } else {
    diff = diff / 1000
  }
  diff = roundToDecimal(diff, prec.value)
  diff = diff.toFixed(prec.value)
  console.log(diff)
  value.value = diff
}
onMounted(function() {
  setInterval(updateTime, 5)
})
</script>

<template>
  <div :style="{ userSelect: 'none' }">
    <context-holder />
    <a-drawer
      v-model:open="dopen"
      title="设置"
      placement="right"
    >
      <template #extra>
        <a-popconfirm
          title="确定重置?"
          ok-text="是"
          cancel-text="否"
          @confirm="resetValue"
        >
          <a-button type="primary" danger>重置</a-button>
        </a-popconfirm>
      </template>
      <a-space>
        时间单位:
        <a-radio-group v-model:value="unit">
          <a-radio-button value="h">小时</a-radio-button>
          <a-radio-button value="m">分钟</a-radio-button>
          <a-radio-button value="s">秒</a-radio-button>
        </a-radio-group>
      </a-space>

      <a-divider />

      <a-space>
        目标时间:
        <a-time-picker
          v-model:value="targetTime"
        />
      </a-space>

      <a-divider />

      <a-space>
        保留小数位数:
        <a-input-number :min="0" :max="6" :step="1" v-model:value="prec"/>
      </a-space>

      <a-divider />

      <a-space direction="vertical">
        <a-space>
          第一标题:
          <a-input v-model:value="title1" />
        </a-space>
        <a-space>
          第二标题:
          <a-input v-model:value="title2" />
        </a-space>
      </a-space>

      <a-divider />

      <a-row align="middle" style="margin-bottom: 8px;">
        <a-col :span="12">
          第一标题字体大小
        </a-col>
        <a-col :span="12">
          <a-input-number v-model:value="t1fsize" :min="10" :max="1000" :step="1" />
        </a-col>
      </a-row>
      <a-row align="middle" style="margin-bottom: 8px;">
        <a-col :span="12">
          时间字体大小
        </a-col>
        <a-col :span="12">
          <a-input-number v-model:value="vfsize" :min="10" :max="1000" :step="1" />
        </a-col>
      </a-row>
      <a-row align="middle" style="margin-bottom: 8px;">
        <a-col :span="12">
          第二标题字体大小
        </a-col>
        <a-col :span="12">
          <a-input-number v-model:value="t2fsize" :min="10" :max="1000" :step="1" />
        </a-col>
      </a-row>

      <a-divider />

      <div>
        高级选项:
        <a-tag color="error">可能影响正常运行，请谨慎修改</a-tag>
        <br/>
        <br/>
        <a-row align="middle" style="margin-bottom: 8px;">
          <a-col :span="12">
            Flex 父容器高度偏移:
          </a-col>
          <a-col :span="12">
            <a-input-number v-model:value="heightOffset" :min="-500" :max="500" :step="1" />
          </a-col>
        </a-row>
      </div>

    </a-drawer>



    <a-page-header
      style="border: 1px solid rgb(235, 237, 240); height: 80px"
      title="下课放学倒计时器"
      sub-title="Class and School Dismissal Countdown"

    >
      <template #extra>
        <a-space direction="vertical">
          <a-button type="primary" @click="showDrawer">设置</a-button>
        </a-space>
        
      </template>
    </a-page-header>
    <!--
    <div>
      <div :style="{ height: 'calc((100vh - 80px) * 0.2)', position: 'relative' }">
        <p :style="{ fontSize: t1fsize + 'px', alignSelf: 'start', position: 'absolute', top: 0, left: '50%', transform: 'translateX(-50%)', margin: 0 }">{{ title1 }}</p>
      </div>
      <div :style="{ height: 'calc(((100vh - 80px) * 0.6) - 10px)', position: 'relative' }">
        <p :style="{ fontSize: vfsize + 'px', alignSelf: 'start', position: 'absolute', top: '50%', left: '50%', transform: 'translate(-50%, -50%)', margin: 0  }">{{ value }}</p>
      </div>
      <div :style="{ height: 'calc((100vh - 80px) * 0.2)', position: 'relative' }">
        <p :style="{ fontSize: t2fsize + 'px', alignSelf: 'end', position: 'absolute', bottom: 0, left: '50%', transform: 'translateX(-50%)', margin: 0  }">{{ title2 }}</p>
      </div>
    </div>
    -->
    <div :style="{display: 'flex', flexDirection: 'column', height: `calc(100vh + ${heightOffset}px)`}">
      <div style="flex: 0 0 20%; display: flex; align-items: start; justify-content: center;">
        <p :style="{ fontSize: t1fsize + 'px', margin: 0 }">{{ title1 }}</p>
      </div>
      <div style="flex: 1; display: flex; align-items: center; justify-content: center;">
        <p :style="{ fontSize: vfsize + 'px', margin: 0 }">{{ value }}</p>
      </div>
      <div style="flex: 0 0 20%; display: flex; align-items: end; justify-content: center;">
        <p :style="{ fontSize: t2fsize + 'px', margin: 0 }">{{ title2 }}</p>
      </div>
    </div>
  </div>
</template>
