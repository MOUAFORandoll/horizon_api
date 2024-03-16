<?php

namespace App\Entity;

use App\Repository\UserObjectRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: UserObjectRepository::class)]
class UserObject
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $src = null;

    #[ORM\Column(type: Types::DATETIME_MUTABLE)]
    private ?\DateTimeInterface $date_created = null;

    #[ORM\ManyToOne(inversedBy: 'userObjects')]
    private ?UserPlateform $user_plateform = null;

    public function __construct()
    {
        $this->date_created = new \DateTime();
    }
    public function getId(): ?int
    {
        return $this->id;
    }

    public function getSrc(): ?string
    {
        return $this->src;
    }

    public function setSrc(string $src): static
    {
        $this->src = $src;

        return $this;
    }

    public function getDateCreated(): ?\DateTimeInterface
    {
        return $this->date_created;
    }

    public function setDateCreated(\DateTimeInterface $date_created): static
    {
        $this->date_created = $date_created;

        return $this;
    }

    public function getUserPlateform(): ?UserPlateform
    {
        return $this->user_plateform;
    }

    public function setUserPlateform(?UserPlateform $user_plateform): static
    {
        $this->user_plateform = $user_plateform;

        return $this;
    }
}
