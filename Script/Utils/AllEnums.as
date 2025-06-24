

enum EGameCharacterType
{
    TOWER,
    MAIN_TOWER,
    MONSTER,
    BOSS_MONSTER,
    MAX
}

enum EBulletType
{
    BulletDirectLine, // 无障碍直线攻击
    BulletLine,       // 非跟踪类型，类似手枪子弹
    BulletTrackLine,  // 跟踪类型
    BulletRangeLine,  // 范围伤害，丢手雷
    BulletRange,      // 范围伤害，类似手雷
    BulletChain,      // 链条类型，持续伤害类型
}