class ATowerDefenceHallGameMode : AGameMode
{
    default PlayerControllerClass = ATowerDefenceHallPlayerController;
    default GameStateClass = ATowerDefenceHallGameState;
    default DefaultPawnClass = ATowerDefenceHallPawn;
    default HUDClass = ATowerDefenceHallHUD;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        
    }
};