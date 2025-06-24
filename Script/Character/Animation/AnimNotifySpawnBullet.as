class UAnimNotifySpawnBullet : UAnimNotify
{
    UPROPERTY(EditAnywhere, BlueprintReadWrite)
    TSubclassOf<ABulletBase> BulletClass;

    UPROPERTY()
    FName BoneName;

    UFUNCTION(BlueprintOverride)
    bool Notify(USkeletalMeshComponent MeshComp, UAnimSequenceBase Animation, FAnimNotifyEventReference EventReference) const
    {
        ACharacterBase AnimOwner = Cast<ACharacterBase>(MeshComp.GetOwner());
        if (IsValid(AnimOwner))
        {
            FTransform BoneTransform = MeshComp.GetBoneTransform(BoneName);

            ABulletBase Bullet = Cast<ABulletBase>(SpawnActor(BulletClass, BoneTransform.Location, BoneTransform.Rotation.Rotator()));
            if (IsValid(Bullet))
            {
                Bullet.Instigator = Cast<APawn>(AnimOwner);
            }
        }

        return true;
    }
};