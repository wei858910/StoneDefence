class UAnimNotifySpawnBullet : UAnimNotify
{
    UPROPERTY(EditAnywhere, BlueprintReadWrite)
    TSubclassOf<ABulletBase> BulletClass;

    UFUNCTION(BlueprintOverride)
    bool Notify(USkeletalMeshComponent MeshComp, UAnimSequenceBase Animation, FAnimNotifyEventReference EventReference) const
    {
        ACharacterBase AnimOwner = Cast<ACharacterBase>(MeshComp.GetOwner());
        if (IsValid(AnimOwner))
        {
            auto FirePoint = AnimOwner.GetFirePoint();
            if (IsValid(FirePoint))
            {
                ABulletBase Bullet = Cast<ABulletBase>(SpawnActor(BulletClass, FirePoint.GetWorldLocation(), FirePoint.GetWorldRotation()));
                if (IsValid(Bullet))
                {
                    Bullet.Instigator = Cast<APawn>(AnimOwner);
                }
            }
        }

        return true;
    }
};