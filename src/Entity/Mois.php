<?php

namespace App\Entity;

use App\Repository\MoisRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use ApiPlatform\Core\Annotation\ApiResource;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Annotation\Groups;

#[ORM\Entity(repositoryClass: MoisRepository::class)]
#[ApiResource()]
class Mois
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    #[Groups(["read:sanction-employe", "read:paiement"])]
    private ?string $libelle = null;

    #[ORM\OneToMany(mappedBy: 'mois', targetEntity: Paiement::class)]
    private Collection $paiements;

    #[ORM\Column(nullable: true)]
    private ?int $numSigle = null;

    #[ORM\OneToMany(mappedBy: 'mois', targetEntity: Absences::class)]
    private Collection $absences;

    #[ORM\OneToMany(mappedBy: 'mois', targetEntity: ListEmployeSanction::class)]
    private Collection $listEmployeSanctions;

    public function __construct()
    {
        $this->paiements = new ArrayCollection();
        $this->absences = new ArrayCollection();
        $this->listEmployeSanctions = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getLibelle(): ?string
    {
        return $this->libelle;
    }

    public function setLibelle(string $libelle): static
    {
        $this->libelle = $libelle;

        return $this;
    }

    /**
     * @return Collection<int, Paiement>
     */
    public function getPaiements(): Collection
    {
        return $this->paiements;
    }

    public function addPaiement(Paiement $paiement): static
    {
        if (!$this->paiements->contains($paiement)) {
            $this->paiements->add($paiement);
            $paiement->setMois($this);
        }

        return $this;
    }

    public function removePaiement(Paiement $paiement): static
    {
        if ($this->paiements->removeElement($paiement)) {
            // set the owning side to null (unless already changed)
            if ($paiement->getMois() === $this) {
                $paiement->setMois(null);
            }
        }

        return $this;
    }

    public function getNumSigle(): ?int
    {
        return $this->numSigle;
    }

    public function setNumSigle(?int $numSigle): static
    {
        $this->numSigle = $numSigle;

        return $this;
    }

    /**
     * @return Collection<int, Absences>
     */
    public function getAbsences(): Collection
    {
        return $this->absences;
    }

    public function addAbsence(Absences $absence): static
    {
        if (!$this->absences->contains($absence)) {
            $this->absences->add($absence);
            $absence->setMois($this);
        }

        return $this;
    }

    public function removeAbsence(Absences $absence): static
    {
        if ($this->absences->removeElement($absence)) {
            // set the owning side to null (unless already changed)
            if ($absence->getMois() === $this) {
                $absence->setMois(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, ListEmployeSanction>
     */
    public function getListEmployeSanctions(): Collection
    {
        return $this->listEmployeSanctions;
    }

    public function addListEmployeSanction(ListEmployeSanction $listEmployeSanction): static
    {
        if (!$this->listEmployeSanctions->contains($listEmployeSanction)) {
            $this->listEmployeSanctions->add($listEmployeSanction);
            $listEmployeSanction->setMois($this);
        }

        return $this;
    }

    public function removeListEmployeSanction(ListEmployeSanction $listEmployeSanction): static
    {
        if ($this->listEmployeSanctions->removeElement($listEmployeSanction)) {
            // set the owning side to null (unless already changed)
            if ($listEmployeSanction->getMois() === $this) {
                $listEmployeSanction->setMois(null);
            }
        }

        return $this;
    }
}
