class ATowerDefenceGameMode : AGameMode
{
    default GameStateClass = ATowerDefenceGameState;
    default PlayerControllerClass = ATowerDefencePlayerController;
    default DefaultPawnClass = ATowerDefenceGameCamera;
    default PlayerStateClass = ATowerDefencePlayerState;
    default HUDClass = AHUDBase;
};